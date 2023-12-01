#include "messageresponder.h"

MessageResponder::MessageResponder(ClientConnection* client,
                                   QByteArray& message_byte_array,
                                   QByteArray& catalog_byte_array,
                                   SqlService* sql_service) : client(client),
                                                              message_byte_array(message_byte_array),
                                                              catalog_byte_array(catalog_byte_array),
                                                              sql_service(sql_service) {

    qDebug() << message_byte_array;

}

void MessageResponder::run() {

    // Parse message
    QJsonParseError parse_error;
    QJsonDocument json_document_message = QJsonDocument::fromJson(message_byte_array, &parse_error);

    if (parse_error.error != QJsonParseError::NoError) {

        qDebug() << "parse error!";
        qDebug () << parse_error.error;

    }

    QJsonObject json_message_object = json_document_message.object();

    if (client->GetConnectionType() == ConnectionType::UNKNOWN) {


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

                client->SendMessage(byte_array);

                client->SetConnectionType(ConnectionType::CUTOMER);


            } else if (resource_value.toString() == "Employee_connection") {

                QJsonObject message;
                message[QStringLiteral("Method")] = QStringLiteral("POST");
                message[QStringLiteral("Resource")] = QStringLiteral("Employee_connection");
                message[QStringLiteral("Code")] = QStringLiteral("200");
                QByteArray byte_array = QJsonDocument(message).toJson();
                byte_array.append("\n");

                client->SendMessage(byte_array);

                client->SetConnectionType(ConnectionType::EMPLOYEE);

            }

        }

    } else if (client->GetConnectionType() == ConnectionType::CUTOMER) {

        RespondToCustomer(json_message_object);

    } else if (client->GetConnectionType() == ConnectionType::EMPLOYEE) {

        RespondToEmployee(json_message_object);

    }


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

            if (client->IsLoggedIn()) {

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

                client->SendMessage(message_byte_array);

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Catalog") {

            SendCatalog();

        } else if (resource_value.toString() == "Orders_history") {



        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Connection") {




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



        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {



        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Connection") {



        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Order_received") {



        }

    }

}

void MessageResponder::LoginCustomer(const QString& phone_number, const QString& password) {

    if (!client->IsLoggedIn()) {

        CustomerLoginResult login_result = sql_service->LoginCustomer(phone_number, password);

        if (login_result == CustomerLoginResult::SUCCESS) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("200");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            client->SendMessage(message_byte_array);

        } else if (login_result == CustomerLoginResult::NO_PHONE_IN_DATABASE) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_description")] = QStringLiteral("Phone_is_not_logged");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            client->SendMessage(message_byte_array);

        } else if (login_result == CustomerLoginResult::INCORRECT_PASSWORD) {

            QJsonObject message;
            message[QStringLiteral("Method")] = QStringLiteral("POST");
            message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
            message[QStringLiteral("Code")] = QStringLiteral("403");
            message[QStringLiteral("Error_code")] = QStringLiteral("Incorrect_password");
            QByteArray message_byte_array = QJsonDocument(message).toJson();
            message_byte_array.append("\n");

            client->SendMessage(message_byte_array);

        }

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_code")] = QStringLiteral("User_already_logged");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        client->SendMessage(message_byte_array);

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

        client->SendMessage(message_byte_array);

    } else if (register_result == CustomerRegisterResult::PHONE_ALREADY_REGISTERED) {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Register_customer");
        message[QStringLiteral("Code")] = QStringLiteral("403");
        message[QStringLiteral("Error_description")] = QStringLiteral("Phone_already_registered");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        client->SendMessage(message_byte_array);

    }

}

void MessageResponder::SendCatalog() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Catalog");
    message[QStringLiteral("Code")] = QStringLiteral("200");
    message[QStringLiteral("Catalog")] = QString(catalog_byte_array.toBase64());
    QByteArray message_byte_array = QJsonDocument(message).toJson();
    message_byte_array.append("\n");

    client->SendMessage(message_byte_array);

}

void MessageResponder::AddOrder(const QString &phone_number, const QString &timestamp, const QJsonValue &order_json_value) {

    QJsonArray order_json_array = order_json_value.toArray();

    QVector<QString> order_ids;

    foreach (const QJsonValue & value, order_json_array) {

        QJsonObject obj = value.toObject();
        order_ids.append(obj["product_id"].toString());
        order_ids.append(obj["ammount"].toString());

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

        client->SendMessage(message_byte_array);

    } else {

        QJsonObject message;
        message[QStringLiteral("Method")] = QStringLiteral("POST");
        message[QStringLiteral("Resource")] = QStringLiteral("Order");
        message[QStringLiteral("Code")] = QStringLiteral("400");
        message[QStringLiteral("Error_description")] = QStringLiteral("Order includes incorrect product ID's");
        QByteArray message_byte_array = QJsonDocument(message).toJson();
        message_byte_array.append("\n");

        client->SendMessage(message_byte_array);

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
