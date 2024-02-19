#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}, socket(new QTcpSocket), need_orders_data(true) {

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

void Client::onLogout() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Logout_employee");
    message[QStringLiteral("Name")] = name;
    message[QStringLiteral("Surname")] = surname;
    message[QStringLiteral("Position")] = position;
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
                emit loggedIn(name, surname, position);

                if (need_orders_data) {

                    GetOrders();
                    need_orders_data = false;

                }

            } else {

                QJsonValue error_description_value = json_message_object.value(QLatin1String("Error_description"));
                qDebug() << error_description_value;
                emit showErrorMessage(QString::fromLatin1("Login error!"), error_description_value.toString());

            }

        } else if (resource_value.toString() == "Logout_employee") {

            if (code_value.toString() == "200") {

                emit logoutConfirmed();

            } else {

                QJsonValue error_description_value = json_message_object.value(QLatin1String("Error_description"));
                emit showErrorMessage("Ошибка выхода", error_description_value.toString());

            }

        } else if (resource_value.toString() == "Start_prepearing_order") {

            if (code_value.toString() == "200") {

                int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

                emit startPrepearingOrderConfirmed(order_id);

            } else if (code_value.toString() == "403") {

                emit showErrorMessage("Ошибка подготовки заказа", json_message_object.value(QLatin1String("Error_description")).toString());

            }


        } else if (resource_value.toString() == "Start_issuing_order") {

            if (code_value.toString() == "200") {

                int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();

                emit startIssuingOrderConfirmed(order_id);

            } else if (code_value.toString() == "403") {

                emit showErrorMessage("Ошибка выдачи заказа", json_message_object.value(QLatin1String("Error_description")).toString());

            }

        } else if (resource_value.toString() == "Order") {

            QJsonValue order_id_value = json_message_object.value(QLatin1String("order_id"));
            QJsonValue receive_code = json_message_object.value(QLatin1String("receive_code"));
            QJsonValue phone_number_value = json_message_object.value(QLatin1String("phone_number"));
            QJsonValue timestamp_value = json_message_object.value(QLatin1String("ordered_timestamp"));
            QJsonValue total_cost_value = json_message_object.value(QLatin1String("total_cost"));
            QJsonValue order_json_value = json_message_object.value(QLatin1String("order_data"));
            QJsonValue is_ready_value = json_message_object.value(QLatin1String("is_ready"));

            if (!is_ready_value.toBool()) {

                emit addOrderToOrderPrepearingModel(order_id_value.toInt(), phone_number_value.toString(),
                                                    receive_code.toString(), timestamp_value.toString(),
                                                    total_cost_value.toInt(), order_json_value.toArray(), false);

            }

        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Order_prepeared") {

            if (code_value.toString() == "200") {

                qDebug() << "Order prepeared confirmed ";
                emit orderPrepearedConfirmed(json_message_object.value(QLatin1String("Order_id")).toInt());

            }

        } else if (resource_value.toString() == "Order_received") {

            if (code_value.toString() == "200") {

                qDebug() << "Order received confimed";
                int order_id = json_message_object.value(QLatin1String("Order_id")).toInt();
                QString phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
                QString receive_code = json_message_object.value(QLatin1String("Receive_code")).toString();

                emit orderReceivedConfirmed(order_id, phone_number, receive_code);

            }

        } else if (resource_value.toString() == "Set_order_prepeared") {

            qDebug() << "Set order prepeared";
            emit setOrderPrepeared(json_message_object.value(QLatin1String("Order_id")).toInt());

        } else if (resource_value.toString() == "Set_order_received") {

            qDebug() << "Order received";
            emit setOrderReceived(json_message_object.value(QLatin1String("Order_id")).toInt());

        } else if (resource_value.toString() == "Start_issuing_order") {

            qDebug() << "Emit set start order issuing";
            emit setOrderIssuing(json_message_object.value(QLatin1String("Order_id")).toInt(), true);

        } else if (resource_value.toString() == "Stop_issuing_order") {

            qDebug() << "Emit set stop order issuing";
            emit setOrderIssuing(json_message_object.value(QLatin1String("Order_id")).toInt(), false);

        } else if (resource_value.toString() == "Start_prepearing_order") {

            qDebug() << "Emit set start order prepearing";
            emit setOrderPrepearing(json_message_object.value(QLatin1String("Order_id")).toInt(), true);

        } else if (resource_value.toString() == "Stop_prepearing_order") {

            qDebug() << "Emit set stop order prepearing";
            emit setOrderPrepearing(json_message_object.value(QLatin1String("Order_id")).toInt(), false);

        }


    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {

            if (code_value.toString() == "200") {

                QJsonArray orders_array = json_message_object.value(QLatin1String("Orders")).toArray();

                QJsonArray issuing_order_ids_array = json_message_object.value(QLatin1String("Issuing_order_ids")).toArray();
                QJsonArray prepearing_order_ids_array = json_message_object.value(QLatin1String("Prepearing_order_ids")).toArray();


                for (int i = 0; i < orders_array.size(); ++i) {

                    int order_id = orders_array[i].toObject().value("order_id").toInt();
                    QString ordered_timestamp = orders_array[i].toObject().value("ordered_timestamp").toString();
                    QString receive_code = orders_array[i].toObject().value("receive_code").toString();
                    QString phone_number = orders_array[i].toObject().value("phone_number").toString();
                    size_t total_cost = orders_array[i].toObject().value("total_cost").toInt();
                    QString order_data_string = orders_array[i].toObject().value("order_data").toString();
                    bool is_ready = orders_array[i].toObject().value("is_ready").toBool();

                    bool is_processing = prepearing_order_ids_array.contains(QJsonValue(order_id)) ||
                                         issuing_order_ids_array.contains(QJsonValue(order_id));

                    QString ordered_timestamp_formated = ordered_timestamp.replace("T", " ");
                    ordered_timestamp_formated = ordered_timestamp_formated.left(16);

                    QJsonArray order_data_array = QJsonDocument::fromJson(order_data_string.toUtf8()).array();

                    if (is_ready) {

                        qDebug() << "Add order issuing " << order_id << " " << is_processing;

                        emit addOrderToOrederIssuingModel(order_id, ordered_timestamp_formated, receive_code,
                                                          phone_number, total_cost, order_data_array, is_processing);

                    } else {

                        qDebug() << "Add order prepearing " << order_id << " " << is_processing;

                        emit addOrderToOrderPrepearingModel(order_id, phone_number, receive_code, ordered_timestamp_formated,
                                                            total_cost, order_data_array, is_processing);

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

            }

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Order") {

            QJsonValue order_id_value = json_message_object.value(QLatin1String("Order_id"));
            emit removeOrder(order_id_value.toInt());

        } else if (resource_value.toString() == "Prepearing_order") {

            if (code_value.toString() == "200") {

                emit stopPrepearingOrderConfirmed();

            } else {

                emit showErrorMessage("Ошибка подготовки заказа", json_message_object.value(QLatin1String("Error_description")).toString());

            }

        } else if (resource_value.toString() == "Issuing_order") {

            if (code_value.toString() == "200") {

                emit stopIssuingOrderConfirmed();

            } else {

                emit showErrorMessage("Ошибка выдачи заказа", json_message_object.value(QLatin1String("Error_description")).toString());

            }

        }


    }


}

void Client::onStartPrepearingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Start_prepearing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onStartIssuingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Start_issuing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onStopPrepearingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
    message[QStringLiteral("Resource")] = QStringLiteral("Prepearing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onStopIssuingOrder(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
    message[QStringLiteral("Resource")] = QStringLiteral("Issuing_order");
    message[QStringLiteral("Order_id")] = order_id;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onOrderPrepearedMessage(const int &order_id, const QString &phone_number, const QString& receive_code) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Order_prepeared");
    message[QStringLiteral("Order_id")] = order_id;
    message[QStringLiteral("Phone_number")] = phone_number;
    message[QStringLiteral("Receive_code")] = receive_code;
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
    message[QStringLiteral("Received_timestamp")] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}


void Client::deleteConnection() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
    message[QStringLiteral("Resource")] = QStringLiteral("Employee_connection");
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
