#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}, socket(new QTcpSocket) {

    connect(socket, &QTcpSocket::readyRead, this, &Client::onReadyRead);
    connect(socket, &QTcpSocket::disconnected, this, &Client::onDisconnected);

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

void Client::onLogin(const QString& name, const QString& surname,
                     const QString& position, const QString& password) {

    this->name = name;
    this->surname = surname;
    this->position = position;

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Login_employee");
    message[QStringLiteral("Name")] = name;
    message[QStringLiteral("Surname")] = surname;
    message[QStringLiteral("Position")] = position;
    message[QStringLiteral("Password")] = password;
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

        if (resource_value.toString() == "Employee_connection") {

            if (code_value.toString() == "200") {

                qDebug() << "Employee connection accepted";

            }

        } else if (resource_value.toString() == "Login_employee") {

            if (code_value.toString() == "200") {

                qDebug() << "Logged in successfully!";
                GetCatalog();
                emit loggedIn(name, surname, position);

            } else {

                QJsonValue error_description_value = json_message_object.value(QLatin1String("Error_description"));
                qDebug() << error_description_value;
                emit showErrorMessage(QString::fromLatin1("Login error!"), error_description_value.toString());

            }

        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Start_prepearing_order") {



        } else if (resource_value.toString() == "Start_issuing_order") {



        } else if (resource_value.toString() == "Order_prepeared") {



        } else if (resource_value.toString() == "Order_received") {



        }


    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {

            if (code_value.toString() == "200") {

                QJsonArray orders_array = json_message_object.value(QLatin1String("Orders")).toArray();

                for (int i = 0; i < orders_array.size(); ++i) {

                    size_t order_id = orders_array[i].toObject().value("order_id").toInt();
                    QString ordered_timestamp = orders_array[i].toObject().value("ordered_timestamp").toString();
                    QString receive_code = orders_array[i].toObject().value("receive_code").toString();
                    QString phone_number = orders_array[i].toObject().value("phone_number").toString();
                    size_t total_cost = orders_array[i].toObject().value("total_cost").toInt();
                    QString order_data_string = orders_array[i].toObject().value("order_data").toString();
                    bool is_ready = orders_array[i].toObject().value("is_ready").toBool();

                    QString ordered_timestamp_formated = ordered_timestamp.replace("T", " ");
                    ordered_timestamp_formated = ordered_timestamp_formated.left(16);

                    QJsonArray order_data_array = QJsonDocument::fromJson(order_data_string.toUtf8()).array();

                    if (is_ready) {

                        emit addOrderToOrederIssuingModel(order_id, ordered_timestamp_formated, receive_code,
                                                          phone_number, total_cost, order_data_array);

                    } else {

                        emit addOrderToOrderPrepearingModel(order_id, phone_number, ordered_timestamp_formated,
                                                            total_cost, order_data_array);

                    }


                }


            } else if (code_value.toString() == "503") {

                QJsonValue error_description_value = json_message_object.value(QLatin1String("Error_description"));

                emit errorOccurred(QString::fromLatin1("Order data error!"), error_description_value.toString());

            }

        } else if (resource_value.toString() == "Catalog") {

            if (code_value.toString() == "200") {

                qDebug () << "Catalog!";

                QJsonValue catalog_array = json_message_object.value(QLatin1String("Catalog"));

                qDebug() << QJsonDocument(catalog_array.toObject()).toJson();

                GetOrders();

            }

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Order") {

            QJsonValue order_id_value = json_message_object.value(QLatin1String("Order_id"));
            emit removeOrder(order_id_value.toInt());

        }

    }

}

void Client::onStartPrepearingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onStartIssuingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onOrderPrepearedMessage(const int &order_id, const QString &phone_number) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
    message[QStringLiteral("Order_id")] = order_id;
    message[QStringLiteral("Phone_number")] = phone_number;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onOrderReceivedMessage(const int &order_id, const QString &phone_number, const QString &receive_code) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Order_received");
    message[QStringLiteral("Order_id")] = order_id;
    message[QStringLiteral("Phone_number")] = phone_number;
    message[QStringLiteral("Receive_code")] = receive_code;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}


void Client::deleteConnection() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
    message[QStringLiteral("Resource")] = QStringLiteral("Connection");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onDisconnected() {

    showErrorMessage("Ошибка соединения", "Соединение с сервером прервано");

}

void Client::SendConnectionType() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Employee_connection");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    if (socket->state() == QAbstractSocket::ConnectedState) {

        qintptr bytes_written = socket->write(byte_array);
        qDebug() << bytes_written;

    } else {

        qDebug() << "cant send connection type: disconnected!";

    }

}

void Client::GetOrders() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Orders");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

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
