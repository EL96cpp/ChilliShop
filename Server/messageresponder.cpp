#include "messageresponder.h"

MessageResponder::MessageResponder(ClientConnection* client, QByteArray& message_byte_array,
                                   SqlService* sql_service) : client(client),
                                                              message_byte_array(message_byte_array),
                                                              sql_service(sql_service)
{

    qDebug() << message_byte_array;

}

void MessageResponder::run()
{

    // Parse message
    QJsonParseError parse_error;
    QJsonDocument json_document_message = QJsonDocument::fromJson(message_byte_array, &parse_error);

    if (parse_error.error != QJsonParseError::NoError) {

        qDebug() << "parse error!";
        qDebug () << parse_error.error;

    }

    QJsonObject json_message_object = json_document_message.object();

    if (client->GetConnectionType() == ConnectionType::UNKNOWN) {

        QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

        if (resource_value.toString() == "Catalog") {

            client->SetConnectionType(ConnectionType::CUTOMER);

        } else if (resource_value.toString() == "Employee_list") {

            client->SetConnectionType(ConnectionType::EMPLOYEE);

        }

    } else if (client->GetConnectionType() == ConnectionType::CUTOMER) {

        RespondToCustomer(json_message_object);

    } else if (client->GetConnectionType() == ConnectionType::EMPLOYEE) {

        RespondToEmployee(json_message_object);

    }


}

void MessageResponder::RespondToCustomer(const QJsonObject& json_message_object)
{
    QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
    QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

    if (method_value.toString() == "POST") {

        if (resource_value.toString() == "Login_customer") {

        } else if (resource_value.toString() == "Register_customer") {

        } else if (resource_value.toString() == "Order") {

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Catalog") {

        } else if (resource_value.toString() == "Orders_history") {

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Connection") {



        } else if (resource_value.toString() == "Order") {


        }


    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "User_name") {

        }

    }
}

void MessageResponder::RespondToEmployee(const QJsonObject& json_message_object)
{
    QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
    QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));

    if (method_value.toString() == "POST") {

        if (resource_value.toString() == "Login_employee") {

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Employees_list") {

        } else if (resource_value.toString() == "Orders") {

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Connection") {

        }


    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Order_received") {

        }

    }

}
