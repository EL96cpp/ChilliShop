#include "client.h"

Client::Client() : socket(new QSslSocket) {

    connect(socket, &QSslSocket::readyRead, this, &Client::onReadyRead);

}


void Client::ConnectToServer(const QString& address, const quint16& port) {

    socket->connectToHost(address, port);
    qDebug() << socket->state();

    if (!socket->waitForConnected(3000)) {

        qDebug() << "Connection error!";

    } else {

        SendConnectionType();
        qDebug() << "Connected!";

    }

}

void Client::onLogin(const QString& phone_number, const QString& password) {

    qDebug() << "Login try!";
    qDebug() << phone_number << " " << password;
    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
    message[QStringLiteral("Phone number")] = phone_number;
    message[QStringLiteral("Password")] = password;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    if (socket->state() == QAbstractSocket::ConnectedState) {

        qintptr bytes_written = socket->write(byte_array);
        qDebug() << bytes_written;
        qDebug() << byte_array.toStdString();
        qDebug() << byte_array.toStdString();

    } else {

        qDebug() << "cant login: disconnected!";

    }

}


void Client::onRegister(const QString& phone_number, const QString& password, const QString& name) {

    qDebug() << "Register try!";
    qDebug() << phone_number << " " << password;
    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Register_customer");
    message[QStringLiteral("Phone number")] = phone_number;
    message[QStringLiteral("Password")] = password;
    message[QStringLiteral("Name")] = name;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    if (socket->state() == QAbstractSocket::ConnectedState) {

        qintptr bytes_written = socket->write(byte_array);
        qDebug() << bytes_written;

    } else {

        qDebug() << "cant register: disconnected!";

    }

}

void Client::onMakeOrder(const QString &phone_number, const QString &order_datetime, const QJsonObject &order_data) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Order");

}

void Client::SendConnectionType() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Customer_connection");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    if (socket->state() == QAbstractSocket::ConnectedState) {

        qintptr bytes_written = socket->write(byte_array);
        qDebug() << bytes_written;

    } else {

        qDebug() << "cant send connection type: disconnected!";

    }

}

void Client::GetCatalog() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Catalog");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::GetOrdersHistory() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Orders_history");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onReadyRead() {

    QByteArray message_byte_array = socket->readAll();

    // Parse message
    QJsonParseError parse_error;
    QJsonDocument json_document_message = QJsonDocument::fromJson(message_byte_array, &parse_error);

    if (parse_error.error != QJsonParseError::NoError) {

        qDebug() << "parse error!";
        qDebug () << parse_error.errorString();

    }

    QJsonObject json_message_object = json_document_message.object();

    QJsonValue method_value = json_message_object.value(QLatin1String("Method"));
    QJsonValue resource_value = json_message_object.value(QLatin1String("Resource"));
    QJsonValue code_value = json_message_object.value(QLatin1String("Code"));

    if (method_value.toString() == "POST") {

        if (resource_value.toString() == "Customer_connection") {

            if (code_value.toString() == "200") {

                qDebug() << "Employee connection accepted";
                GetCatalog();

            }

        } else if (resource_value.toString() == "Login_customer") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            }

        } else if (resource_value.toString() == "Register_customer") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            }

        } else if (resource_value.toString() == "Order") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            } else if (code_value.toString() == "400") {

            }

        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Change_customer_name") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            }

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Order") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Order_history") {

            if (code_value.toString() == "200") {

            } else if (code_value.toString() == "403") {

            }

        } else if (resource_value.toString() == "Catalog") {

            if (code_value.toString() == "200") {


                QJsonValue json_array_value = json_message_object.value(QLatin1String("Catalog"));
                QJsonArray json_array = json_array_value.toArray();

                for(int i = 1; i < json_array.size(); ++i) {

                    QJsonObject json = json_array.at(i).toObject();
                    qDebug() << json.value(QLatin1String("product_id")).toString();
                    qDebug() << json.value(QLatin1String("product_type")).toString();
                    qDebug() << json.value(QLatin1String("product_name")).toString();
                    qDebug() << json.value(QLatin1String("price")).toString();
                    qDebug() << json.value(QLatin1String("scoville")).toString();
                    qDebug() << json.value(QLatin1String("description")).toString();

                }


            }

        }

    }



}
