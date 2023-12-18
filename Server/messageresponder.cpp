#include "messageresponder.h"
#include "clientconnection.h"
#include "sqlservice.h"


MessageResponder::MessageResponder(QObject* parent,
                                   const QByteArray& message_byte_array,
                                   const ConnectionType& connection_type,
                                   std::atomic<unsigned long long>& sql_connections_counter,
                                   const bool& logged_in) : QObject{parent},
                                                            message_byte_array(message_byte_array),
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

                qDebug() << "Customer connection will be set";

                emit SetConnectionType(ConnectionType::CUSTOMER);
                emit MessageResponce(byte_array);


            } else if (resource_value.toString() == "Employee_connection") {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Employee_connection");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                QByteArray byte_array = QJsonDocument(message).toJson();
                byte_array.append("\n");

                qDebug() << "Employee connection will be set";

                emit SetConnectionType(ConnectionType::EMPLOYEE);
                emit MessageResponce(byte_array);

            }

        }

    } else if (connection_type == ConnectionType::CUSTOMER) {

        qDebug() << "Customer responce will be done";
        RespondToCustomer(json_message_object);

    } else if (connection_type == ConnectionType::EMPLOYEE) {

        qDebug() << "Employee responce will be done";
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
                QJsonValue order_json_value = json_message_object.value(QLatin1String("Order"));

                AddOrder(phone_number_value.toString(), timestamp_value.toString(), order_json_value);

            } else {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Order");
                message[QStringLiteral("Code")] = QStringLiteral("403");
                message[QStringLiteral("Error_code")] = QStringLiteral("Customer is not logged");
                QByteArray message_byte_array = QJsonDocument(message).toJson();
                message_byte_array.append("\n");

                emit MessageResponce(message_byte_array);

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Catalog") {

            emit SendCatalog();

        } else if (resource_value.toString() == "Orders_history") {



        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Connection") {

            qDebug() << "customer connection will be deleted!";
            emit DeleteConnection();

        } else if (resource_value.toString() == "Order") {



        }


    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Change_user_name") {



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

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {



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

        if (resource_value.toString() == "Connection") {

            qDebug() << "employee connection will be deleted!";
            emit DeleteConnection();

        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Order_received") {



        }

    }

}

void MessageResponder::LoginCustomer(const QString& phone_number, const QString& password) {

    if (!logged_in) {

        CustomerLoginResult login_result = sql_service->LoginCustomer(phone_number, password);

        if (login_result == CustomerLoginResult::SUCCESS) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("200");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

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
            message[QStringLiteral("Error_code")] = QStringLiteral("Incorrect_password");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            emit MessageResponce(message_byte_array);

        }

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_code")] = QStringLiteral("User_already_logged");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    }

}

void MessageResponder::LoginEmployee(const QString &name, const QString &surname, const QString &position, const QString &password) {

    EmployeeLoginResult login_result = sql_service->LoginEmployee(name, surname, position, password);

    if (login_result == EmployeeLoginResult::SUCCESS) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
        message[QStringLiteral("Code")] = QStringLiteral("200");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");


        qDebug() << "login employee 200";
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


void MessageResponder::AddOrder(const QString &phone_number, const QString &timestamp, const QJsonValue &order_json_value) {

    QJsonArray order_json_array = order_json_value.toArray();

    QVector<int> order_ids;

    foreach (const QJsonValue & value, order_json_array) {

        QJsonObject obj = value.toObject();
        order_ids.push_back(obj["product_id"].toInt());

    }

    if (sql_service->CheckIfOrderIsCorrect(order_ids)) {

        QString order_code = GenerateOrderCode();

        sql_service->AddOrder(phone_number, timestamp, order_json_array, order_code);

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Order");
        message[QStringLiteral("Code")] = QStringLiteral("200");
        message[QStringLiteral("Order_code")] = order_code;
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

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

void MessageResponder::AddReceivedOrder(const int &order_id, const QString &phone_number, const QString &ordered_timestamp, const QString& received_timestamp, const QString &receive_code, const QMap<int, int> &order_data) {

    AddReceivedOrderResult result = sql_service->AddReceivedOrder(order_id, phone_number, ordered_timestamp, received_timestamp, receive_code, order_data);

    if (result == AddReceivedOrderResult::SUCCESS) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("PUT");
        message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
        message[QStringLiteral("Code")] = QStringLiteral("200");
        message[QStringLiteral("Order_id")] = QString::number(order_id);
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    } else if (result == AddReceivedOrderResult::NO_ORDER_IN_DATABASE) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("PUT");
        message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Order_id")] = QString::number(order_id);
        message[QStringLiteral("Error_description")] = QStringLiteral("No order in database");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        emit MessageResponce(message_byte_array);

    } else if (result == AddReceivedOrderResult::INCORRECT_PRODUCT_ID) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("PUT");
        message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Order_id")] = QString::number(order_id);
        message[QStringLiteral("Error_description")] = QStringLiteral("Order includes incorrect product ID's");
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

    qDebug() << "oder code " << order_code;
    return order_code;

}
