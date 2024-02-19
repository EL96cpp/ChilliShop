#include "messageresponder.h"
#include "clientconnection.h"
#include "sqlservice.h"


MessageResponder::MessageResponder(QObject* parent,
                                   const QByteArray& message_byte_array,
                                   ConnectionsVector& connections,
                                   OrderIDVector& prepearing_order_ids,
                                   OrderIDVector& issuing_order_ids,
                                   const ConnectionType& connection_type,
                                   std::atomic<unsigned long long>& sql_connections_counter,
                                   const bool& logged_in,
                                   const QString& phone_number,
                                   const EmployeeData& employee_data) : QObject{parent},
                                                                        phone_number(phone_number),
                                                                        employee_data(employee_data),
                                                                        message_byte_array(message_byte_array),
                                                                        connections(connections),
                                                                        prepearing_order_ids(prepearing_order_ids),
                                                                        issuing_order_ids(issuing_order_ids),
                                                                        connection_type(connection_type),
                                                                        sql_connections_counter(sql_connections_counter),
                                                                        logged_in(logged_in) {

    qDebug() << message_byte_array;

}

MessageResponder::~MessageResponder() {

    qDebug() << "message responder deleted!";

}

void MessageResponder::run() {

    QString sql_connection_name = QString::number(sql_connections_counter);
    sql_service = new SqlService(sql_connection_name);


    sql_connections_counter++;

    // Parse message
    QJsonParseError parse_error;
    QJsonDocument json_document_message = QJsonDocument::fromJson(message_byte_array, &parse_error);

    if (parse_error.error != QJsonParseError::NoError) {

        qDebug() << "parse error!";
        qDebug () << parse_error.errorString();

    }

    QJsonObject json_message_object = json_document_message.object();

    if (connection_type == ConnectionType::UNKNOWN) {

        QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
        QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

        if (method_value.toString() == "POST") {

            if (resource_value.toString() == "Customer_connection") {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Customer_connection");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                QByteArray byte_array = QJsonDocument(message).toJson();
                byte_array.append("\n");

                emit SetConnectionType(ConnectionType::CUSTOMER);
                emit MessageResponce(byte_array);


            } else if (resource_value.toString() == "Employee_connection") {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Employee_connection");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                QByteArray byte_array = QJsonDocument(message).toJson();
                byte_array.append("\n");

                emit SetConnectionType(ConnectionType::EMPLOYEE);
                emit MessageResponce(byte_array);

            }

        }

    } else if (connection_type == ConnectionType::CUSTOMER) {

        RespondToCustomer(json_message_object);

    } else if (connection_type == ConnectionType::EMPLOYEE) {

        RespondToEmployee(json_message_object);

    }

    delete sql_service;

}

void MessageResponder::RespondToCustomer(const QJsonObject& json_message_object) {

    QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
    QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

    if (method_value.toString() == "POST") {

        if (resource_value.toString() == "Login_customer") {

            QJsonValue phone_number_value = json_message_object.value(QLatin1String("Phone_number"));
            QJsonValue password_value = json_message_object.value(QLatin1String("Password"));

            LoginCustomer(phone_number_value.toString(), password_value.toString());

        } else if (resource_value.toString() == "Register_customer") {

            QJsonValue phone_number_value = json_message_object.value(QLatin1String("Phone_number"));
            QJsonValue password_value = json_message_object.value(QLatin1String("Password"));
            QJsonValue name_value = json_message_object.value(QLatin1String("Name"));

            RegisterCustomer(phone_number_value.toString(), password_value.toString(), name_value.toString());

        } else if (resource_value.toString() == "Order") {

            if (logged_in) {

                QJsonValue phone_number_value = json_message_object.value(QLatin1String("Phone_number"));
                QJsonValue timestamp_value = json_message_object.value(QLatin1String("Timestamp"));
                QJsonValue total_cost_value = json_message_object.value(QLatin1String("Total_cost"));
                QJsonValue order_json_value = json_message_object.value(QLatin1String("Order_data"));

                AddOrder(phone_number_value.toString(), timestamp_value.toString(), total_cost_value.toInt(), order_json_value);

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Customer is not logged");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        } else if (resource_value.toString() == "Logout_customer") {

            if (connections.CheckIfCustomerAlreadyLogged(json_message_object.value("Phone_number").toString())) {

                emit SetLoggedOut();

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Logout_customer");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Logout_customer");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Customer is not logged");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Catalog") {

            emit SendCatalog();

        } else if (resource_value.toString() == "Active_orders") {

            QString phone_number_value = json_message_object.value(QLatin1String("Phone_number")).toString();

            if (logged_in) {

                if (phone_number == phone_number_value) {

                    QJsonArray active_orders = sql_service->GetCustomerActiveOrders(phone_number);

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("GET");
                    message[QStringLiteral("Resource")] = QStringLiteral("Active_orders");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Orders")] = active_orders;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("GET");
                    message[QStringLiteral("Resource")] = QStringLiteral("Active_orders");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect phone number!");
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);


                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("GET");
                message[QStringLiteral("Resource")] = QStringLiteral("Active_orders");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Customer is not logged!");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        } else if (resource_value.toString() == "Received_orders") {

            QString phone_number_value = json_message_object.value(QLatin1String("Phone_number")).toString();

            if (logged_in) {

                if (phone_number == phone_number_value) {

                    QJsonArray received_orders = sql_service->GetCustomerReceivedOrders(phone_number);

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("GET");
                    message[QStringLiteral("Resource")] = QStringLiteral("Received_orders");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Orders")] = received_orders;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("GET");
                    message[QStringLiteral("Resource")] = QStringLiteral("Received_orders");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect phone number!");
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("GET");
                message[QStringLiteral("Resource")] = QStringLiteral("Received_orders");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Customer is not logged!");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Customer_connection") {

            qDebug() << "customer connection will be deleted!";
            connections.eraseByPhoneNumber(phone_number);

        } else if (resource_value.toString() == "Order") {

            qDebug() << "Trying to cancel order!";

            if (logged_in) {

                int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();
                QString phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
                QString receive_code = json_message_object.value(QLatin1String("Receive_code")).toString();

                if (sql_service->CheckIfOrderExists(order_id, phone_number, receive_code)) {

                    if (sql_service->CancelOrder(order_id, phone_number, receive_code)) {

                        QJsonObject message;
                        message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                        message[QStringLiteral("Resource")] = QStringLiteral("Order");
                        message[QStringLiteral("Code")] = QStringLiteral("200");
                        message[QStringLiteral("Order_id")] = order_id;
                        QByteArray message_byte_array = QJsonDocument(message).toJson();
                        message_byte_array.append("\n");

                        emit MessageResponce(message_byte_array);

                        QJsonObject employees_message;
                        employees_message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                        employees_message[QStringLiteral("Resource")] = QStringLiteral("Order");
                        employees_message[QStringLiteral("Order_id")] = order_id;
                        QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                        employees_message_byte_array.append("\n");

                        emit SendToAllEmployees(employees_message_byte_array);


                    } else {

                        QJsonObject message;
                        message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                        message[QStringLiteral("Resource")] = QStringLiteral("Order");
                        message[QStringLiteral("Code")] = QStringLiteral("500");
                        message[QStringLiteral("Error_description")] = QStringLiteral("Server error!");
                        QByteArray message_byte_array = QJsonDocument(message).toJson();
                        message_byte_array.append("\n");

                        emit MessageResponce(message_byte_array);

                    }

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                    message[QStringLiteral("Resource")] = QStringLiteral("Order");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect order ID!");
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }


            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                message[QStringLiteral("Resource")] = QStringLiteral("Order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);


            }

        }


    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Change_customer_name") {

            if (!logged_in) {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("PUT");
                message[QStringLiteral("Resource")] = QStringLiteral("Change_customer_name");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Customer is not logged");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            } else {

                QString phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
                QString new_name = json_message_object.value(QLatin1String("Name")).toString();

                if (sql_service->ChangeCustomerName(phone_number, new_name)) {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    message[QStringLiteral("Resource")] = QStringLiteral("Change_customer_name");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("New_name")] = new_name;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    qDebug() << "Changed customer name to " << new_name;

                    emit MessageResponce(message_byte_array);

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    message[QStringLiteral("Resource")] = QStringLiteral("Change_customer_name");
                    message[QStringLiteral("Code")] = QStringLiteral("500");
                    message[QStringLiteral("Error_description")] = QStringLiteral("Database errror");
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);


                }

            }

        }

    }

}

void MessageResponder::RespondToEmployee(const QJsonObject& json_message_object) {

    QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
    QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

    if (method_value.toString() == "POST") {

        if (resource_value.toString() == "Login_employee") {

            QJsonValue name_value = json_message_object.value(QLatin1String("Name"));
            QJsonValue surname_value = json_message_object.value(QLatin1String("Surname"));
            QJsonValue position_value = json_message_object.value(QLatin1String("Position"));
            QJsonValue password_value = json_message_object.value(QLatin1String("Password"));

            LoginEmployee(name_value.toString(), surname_value.toString(), position_value.toString(), password_value.toString());

        } else if (resource_value.toString() == "Start_prepearing_order") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

            if (logged_in) {

                if (prepearing_order_ids.push(employee_data, order_id)) {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("POST");
                    message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Order_id")] = order_id;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                    QJsonObject employees_message;
                    employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    employees_message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
                    employees_message[QStringLiteral("Order_id")] = order_id;
                    QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                    employees_message_byte_array.append("\n");

                    emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);


                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("POST");
                    message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QString("Заказ ") + QString::number(order_id) + QString(" уже подготавливается\nдругим сотрудником");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }


        } else if (resource_value.toString() == "Start_issuing_order") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

            if (logged_in) {

                if (issuing_order_ids.push(employee_data, order_id)) {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("POST");
                    message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Order_id")] = order_id;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                    QJsonObject employees_message;
                    employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    employees_message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
                    employees_message[QStringLiteral("Order_id")] = order_id;
                    QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                    employees_message_byte_array.append("\n");

                    emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("POST");
                    message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QStringLiteral("Order is already issuing by another employee");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {

            if (logged_in) {

                QJsonArray orders_array = sql_service->GetAllActiveOrders();

                QJsonArray issuing_ids_json_array = issuing_order_ids.getAllOrderIDs();
                QJsonArray prepearing_ids_json_array = prepearing_order_ids.getAllOrderIDs();

                qDebug() << "Issuing order ids size " << issuing_ids_json_array.size();
                qDebug() << "Prepearing order ids size " << prepearing_ids_json_array.size();

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("GET");
                message[QStringLiteral("Resource")] = QStringLiteral("Orders");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                message[QStringLiteral("Orders")] = orders_array;
                message[QStringLiteral("Issuing_order_ids")] = issuing_ids_json_array;
                message[QStringLiteral("Prepearing_order_ids")] = prepearing_ids_json_array;

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("GET");
                message[QStringLiteral("Resource")] = QStringLiteral("Orders");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }


        } else if (resource_value.toString() == "Catalog") {

            QJsonArray catalog_json = sql_service->GetCatalogData();

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("GET");
            message[QStringLiteral("Resource")] = QStringLiteral("Catalog");
            message[QStringLiteral("Code")] = QStringLiteral("200");
            message[QStringLiteral("Catalog")] = catalog_json;

            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Employee_connection") {

            qDebug() << "employee connection will be deleted!";
            prepearing_order_ids.removeAllEmployeeIDs(employee_data);
            issuing_order_ids.removeAllEmployeeIDs(employee_data);
            connections.eraseByEmployeeData(employee_data);

        } else if (resource_value.toString() == "Prepearing_order") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

            if (logged_in) {

                if (prepearing_order_ids.erase(employee_data, order_id)) {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                    message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Order_id")] = order_id;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                    QJsonObject employees_message;
                    employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    employees_message[QStringLiteral("Resource")] = QStringLiteral("Stop_prepearing_order");
                    employees_message[QStringLiteral("Order_id")] = order_id;
                    QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                    employees_message_byte_array.append("\n");

                    emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);


                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                    message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("400");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect order ID");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        } else if (resource_value.toString() == "Issuing_order") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

            if (logged_in) {

                if (issuing_order_ids.erase(employee_data, order_id)) {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                    message[QStringLiteral("Resource")] = QStringLiteral("Issuing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("200");
                    message[QStringLiteral("Order_id")] = order_id;
                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                    QJsonObject employees_message;
                    employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    employees_message[QStringLiteral("Resource")] = QStringLiteral("Stop_issuing_order");
                    employees_message[QStringLiteral("Order_id")] = order_id;
                    QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                    employees_message_byte_array.append("\n");

                    emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);


                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                    message[QStringLiteral("Resource")] = QStringLiteral("Issuing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("400");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect order ID");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("DELETE");
                message[QStringLiteral("Resource")] = QStringLiteral("Issuing_order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }


    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Order_received") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();
            QString phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
            QString receive_code = json_message_object.value(QLatin1String("Receive_code")).toString();
            QString received_timestamp = json_message_object.value(QLatin1String("Received_timestamp")).toString();

            AddReceivedOrder(order_id, phone_number, receive_code, received_timestamp);


        } else if (resource_value.toString() == "Order_prepeared") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();
            QString phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
            QString receive_code = json_message_object.value(QLatin1String("Receive_code")).toString();

            if (logged_in) {

                if (sql_service->CheckIfOrderExists(order_id, phone_number, receive_code)) {

                    if (!sql_service->CheckIfOrderPrepeared(order_id)) {

                        if (sql_service->SetOrderIsReady(order_id)) {

                            prepearing_order_ids.erase(employee_data, order_id);

                            QJsonObject message;
                            message[QStringLiteral("Method")] = QStringLiteral("PUT");
                            message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                            message[QStringLiteral("Code")] = QStringLiteral("200");
                            message[QStringLiteral("Order_id")] = order_id;
                            QByteArray message_byte_array = QJsonDocument(message).toJson();
                            message_byte_array.append("\n");

                            emit MessageResponce(message_byte_array);


                            QJsonObject employees_message;
                            employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                            employees_message[QStringLiteral("Resource")] = QStringLiteral("Set_order_prepeared");
                            employees_message[QStringLiteral("Order_id")] = order_id;
                            QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
                            employees_message_byte_array.append("\n");

                            emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);


                            QJsonObject customer_message;
                            customer_message[QStringLiteral("Method")] = QStringLiteral("PUT");
                            message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                            customer_message[QStringLiteral("Order_id")] = order_id;
                            QByteArray customer_message_byte_array = QJsonDocument(customer_message).toJson();
                            customer_message_byte_array.append("\n");

                            emit SendToCustomer(phone_number, customer_message_byte_array);


                        } else {

                            QJsonObject message;
                            message[QStringLiteral("Method")] = QStringLiteral("PUT");
                            message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                            message[QStringLiteral("Code")] = QStringLiteral("500");
                            message[QStringLiteral("Order_id")] = order_id;
                            message[QStringLiteral("Error_description")] = QStringLiteral("Database error!");

                            QByteArray message_byte_array = QJsonDocument(message).toJson();
                            message_byte_array.append("\n");

                            emit MessageResponce(message_byte_array);

                        }

                    } else {

                        QJsonObject message;
                        message[QStringLiteral("Method")] = QStringLiteral("PUT");
                        message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                        message[QStringLiteral("Code")] = QStringLiteral("403");
                        message[QStringLiteral("Order_id")] = order_id;
                        message[QStringLiteral("Error_description")] = QStringLiteral("Order is already prepeared!");

                        QByteArray message_byte_array = QJsonDocument(message).toJson();
                        message_byte_array.append("\n");

                        emit MessageResponce(message_byte_array);

                    }


                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                    message[QStringLiteral("Code")] = QStringLiteral("403");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect order ID!");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }


            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("PUT");
                message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }


        } else if (resource_value.toString() == "Prepearing_order") {

            int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

            if (logged_in) {

                if (sql_service->CheckIfOrderExists(order_id)) {

                    if (prepearing_order_ids.push(employee_data, order_id)) {

                        QJsonObject message;
                        message[QStringLiteral("Method")] = QStringLiteral("PUT");
                        message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                        message[QStringLiteral("Code")] = QStringLiteral("409");
                        message[QStringLiteral("Order_id")] = order_id;
                        message[QStringLiteral("Error_description")] = QStringLiteral("Order is already prepearing!");

                        QByteArray message_byte_array = QJsonDocument(message).toJson();
                        message_byte_array.append("\n");

                        emit MessageResponce(message_byte_array);

                    }

                } else {

                    QJsonObject message;
                    message[QStringLiteral("Method")] = QStringLiteral("PUT");
                    message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                    message[QStringLiteral("Code")] = QStringLiteral("404");
                    message[QStringLiteral("Order_id")] = order_id;
                    message[QStringLiteral("Error_description")] = QStringLiteral("No such order id!");

                    QByteArray message_byte_array = QJsonDocument(message).toJson();
                    message_byte_array.append("\n");

                    emit MessageResponce(message_byte_array);

                }

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("PUT");
                message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Order_id")] = order_id;
                message[QStringLiteral("Error_description")] = QStringLiteral("Forbidden for non-logged users!");

                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }

    }

}

void MessageResponder::LoginCustomer(const QString& phone_number, const QString& password) {

    if (!logged_in) {

        //Checks if user with this phone number is already logged from another device

        if (connections.CheckIfCustomerAlreadyLogged(phone_number)) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("User_already_logged");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

            return;

        }

        CustomerLoginResult login_result = sql_service->LoginCustomer(phone_number, password);

        if (login_result == CustomerLoginResult::SUCCESS) {

            QString customer_name = sql_service->GetCustomerName(phone_number);

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("200");
            message[QStringLiteral("Phone_number")] = phone_number;
            message[QStringLiteral("Name")] = customer_name;
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit SetLoggedIn(true);
            emit SetCustomerData(phone_number, customer_name);
            emit MessageResponce(message_byte_array);

        } else if (login_result == CustomerLoginResult::NO_PHONE_IN_DATABASE) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("Phone is not registered");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

        } else if (login_result == CustomerLoginResult::INCORRECT_PASSWORD) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect_password");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

        }

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_description")] = QStringLiteral("User_already_logged");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}

void MessageResponder::LoginEmployee(const QString &name, const QString &surname, const QString &position, const QString &password) {

    if (!logged_in) {

        // Checks if employee is already logged from another device

        if (connections.CheckIfEmployeeAlreadyLogged(name, surname, position)) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("User_already_logged");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

            return;

        }

        EmployeeLoginResult login_result = sql_service->LoginEmployee(name, surname, position, password);

        if (login_result == EmployeeLoginResult::SUCCESS) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
            message[QStringLiteral("Code")] = QStringLiteral("200");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");


            qDebug() << "login employee 200";
            emit SetLoggedIn(true);
            emit SetEmployeeData(EmployeeData(name, surname, position));
            emit MessageResponce(message_byte_array);

        } else if (login_result == EmployeeLoginResult::NO_EMPLOYEE_IN_DATABASE) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
            message[QStringLiteral("Code")] = QStringLiteral("400");
            message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect employee data");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            qDebug() << "login employee 400";
            emit MessageResponce(message_byte_array);

        } else if (login_result == EmployeeLoginResult::INCORRECT_PASSWORD) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("Incorrect password");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            qDebug() << "login employee 403";
            emit MessageResponce(message_byte_array);

        }

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_description")] = QStringLiteral("User_already_logged");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}

void MessageResponder::RegisterCustomer(const QString &phone_number, const QString &password, const QString &name) {

    CustomerRegisterResult register_result = sql_service->RegisterCustomer(phone_number, password, name);

    if (register_result == CustomerRegisterResult::SUCCESS) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Register_customer");
        message[QStringLiteral("Code")] = QStringLiteral("200");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    } else if (register_result == CustomerRegisterResult::PHONE_ALREADY_REGISTERED) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Register_customer");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_description")] = QStringLiteral("Phone already registered");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}


void MessageResponder::AddOrder(const QString &phone_number, const QString &timestamp, const int& total_cost, const QJsonValue &order_json_value) {

    QJsonArray order_json_array = order_json_value.toArray();

    QVector<int> order_ids;

    foreach (const QJsonValue & value, order_json_array) {

        QJsonObject obj = value.toObject();
        order_ids.push_back(obj["id"].toInt());

    }

    if (sql_service->CheckIfOrderIsCorrect(order_ids)) {

        qDebug() << "Correct order!";

        QString order_code = GenerateOrderCode();

        int order_id = sql_service->AddOrder(phone_number, timestamp, total_cost, order_json_array, order_code);

        qDebug() << "order id " << order_id;

        if (order_id != 0) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Order");
            message[QStringLiteral("Code")] = QStringLiteral("200");

            message[QStringLiteral("order_id")] = order_id;
            message[QStringLiteral("ordered_timestamp")] = timestamp;
            message[QStringLiteral("receive_code")] = order_code;
            message[QStringLiteral("total_cost")] = total_cost;
            message[QStringLiteral("order_data")] = order_json_array;
            message[QStringLiteral("is_ready")] = false;

            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);


            QJsonObject employees_message;
            employees_message[QStringLiteral("Method")] = QStringLiteral("POST");
            employees_message[QStringLiteral("Resource")] = QStringLiteral("Order");

            employees_message[QStringLiteral("order_id")] = order_id;
            employees_message[QStringLiteral("phone_number")] = phone_number;
            employees_message[QStringLiteral("ordered_timestamp")] = timestamp;
            employees_message[QStringLiteral("receive_code")] = order_code;
            employees_message[QStringLiteral("total_cost")] = total_cost;
            employees_message[QStringLiteral("order_data")] = order_json_array;
            employees_message[QStringLiteral("is_ready")] = false;

            QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
            employees_message_byte_array.append("\n");

            emit SendToAllEmployees(employees_message_byte_array);


        } else {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Order");
            message[QStringLiteral("Code")] = QStringLiteral("500");
            message[QStringLiteral("Error_description")] = QStringLiteral("Database error!");

            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

        }

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Order");
        message[QStringLiteral("Code")] = QStringLiteral("400");
        message[QStringLiteral("Error_description")] = QStringLiteral("Order includes incorrect product ID's");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}

void MessageResponder::AddReceivedOrder(const int &order_id, const QString &phone_number, const QString& receive_code, const QString& received_timestamp) {

    AddReceivedOrderResult result = sql_service->AddReceivedOrder(order_id, phone_number, receive_code, received_timestamp);

    if (result == AddReceivedOrderResult::SUCCESS) {

        issuing_order_ids.erase(employee_data, order_id);

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("PUT");
        message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
        message[QStringLiteral("Code")] = QStringLiteral("200");
        message[QStringLiteral("Order_id")] = order_id;
        message[QStringLiteral("Phone_number")] = phone_number;
        message[QStringLiteral("Receive_code")] = receive_code;
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);


        QJsonObject employees_message;
        employees_message[QStringLiteral("Method")] = QStringLiteral("PUT");
        employees_message[QStringLiteral("Resource")] = QStringLiteral("Set_order_received");
        employees_message[QStringLiteral("Order_id")] = order_id;
        QByteArray employees_message_byte_array = QJsonDocument(employees_message).toJson();
        employees_message_byte_array.append("\n");

        emit SendToAllEmployeesExceptOne(employee_data, employees_message_byte_array);


        QJsonObject customer_message;
        customer_message[QStringLiteral("Method")] = QStringLiteral("PUT");
        customer_message[QStringLiteral("Resource")] = QStringLiteral("Set_order_received");
        customer_message[QStringLiteral("Order_id")] = order_id;
        customer_message[QStringLiteral("Received_timestamp")] = received_timestamp;
        QByteArray customer_message_byte_array = QJsonDocument(customer_message).toJson();
        customer_message_byte_array.append("\n");

        emit SendToCustomer(phone_number, customer_message_byte_array);


    } else if (result == AddReceivedOrderResult::NO_ORDER_IN_DATABASE) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("PUT");
        message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Order_id")] = order_id;
        message[QStringLiteral("Error_description")] = QStringLiteral("No order in database");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}

QString MessageResponder::GenerateOrderCode() {

    QString order_code;

    for (int i = 0; i < 4; ++i) {

        int digit = QRandomGenerator::global()->bounded(10);
        order_code += QString::number(digit);

    }

    return order_code;

}
