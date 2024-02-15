#include "client.h"

Client::Client() : socket(new QSslSocket) {

    connect(socket, &QSslSocket::readyRead, this, &Client::onReadyRead);
    connect(socket, &QSslSocket::disconnected, this, &Client::onDisconnected);

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

    this->phone_number = phone_number;
    qDebug() << "Login try!";
    qDebug() << phone_number << " " << password;
    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Login_customer");
    message[QStringLiteral("Phone_number")] = phone_number;
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
    message[QStringLiteral("Phone_number")] = phone_number;
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

void Client::onMakeOrder(const QJsonArray &order_data, const int& total_cost) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("POST");
    message[QStringLiteral("Resource")] = QStringLiteral("Order");
    message[QStringLiteral("Phone_number")] = phone_number;
    message[QStringLiteral("Timestamp")] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    message[QStringLiteral("Total_cost")] = total_cost;
    message[QStringLiteral("Order_data")] = order_data;

    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qDebug() << byte_array;

    if (socket->state() == QAbstractSocket::ConnectedState) {

        qintptr bytes_written = socket->write(byte_array);
        qDebug() << bytes_written;

    } else {

        qDebug() << "cant make order: disconnected!";

    }

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

void Client::GetActiveOrders() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Active_orders");
    message[QStringLiteral("Phone_number")] = phone_number;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::GetReceivedOrders() {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("GET");
    message[QStringLiteral("Resource")] = QStringLiteral("Received_orders");
    message[QStringLiteral("Phone_number")] = phone_number;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::AddCatalogDataToModels(const QJsonArray &catalog_json_array) {

    for(int i = 0; i < catalog_json_array.size(); ++i) {

        QJsonObject json = catalog_json_array.at(i).toObject();

        QString id = json.value(QLatin1String("product_id")).toString();
        QString type = json.value(QLatin1String("product_type")).toString();
        QString name = json.value(QLatin1String("product_name")).toString();
        QString price = json.value(QLatin1String("price")).toString();
        QString scoville = json.value(QLatin1String("scoville")).toString();
        QString description_string = json.value(QLatin1String("description")).toString();

        QByteArray description_byte_array(description_string.toUtf8());

        QJsonParseError parse_error;
        QJsonDocument description_json_document = QJsonDocument::fromJson(description_byte_array, &parse_error);


        if (type.compare(QStringLiteral("Sauce")) == 0) {

            if (parse_error.error != QJsonParseError::NoError) {

                qDebug() << "parse error!";
                qDebug () << parse_error.errorString();

            } else {

                QJsonObject description_json_object = description_json_document.object();

                QString text_description = description_json_object.value(QLatin1String("text")).toString();
                QString volume = description_json_object.value(QLatin1String("volume_liters")).toString();
                QJsonArray peppers_array = description_json_object.value(QLatin1String("peppers")).toArray();

                emit addSauceProductToModel(id.toInt(), name, type, price.toFloat(), scoville.toInt(), text_description, volume.toFloat(), peppers_array);

            }

        } else if (type.compare(QStringLiteral("Seasoning")) == 0) {

            if (parse_error.error != QJsonParseError::NoError) {

                qDebug() << "parse error!";
                qDebug () << parse_error.errorString();

            } else {

                QJsonObject description_json_object = description_json_document.object();

                QString text_description = description_json_object.value(QLatin1String("text")).toString();
                QString weight_gramms = description_json_object.value(QLatin1String("weight_gramms")).toString();
                QJsonArray peppers_array = description_json_object.value(QLatin1String("peppers")).toArray();

                emit addSeasoningProductToModel(id.toInt(), name, type, price.toFloat(), scoville.toInt(), text_description, weight_gramms.toInt(), peppers_array);

            }


        } else if (type.compare(QStringLiteral("Seeds")) == 0) {

            if (parse_error.error != QJsonParseError::NoError) {

                qDebug() << "parse error!";
                qDebug () << parse_error.errorString();

            } else {

                QJsonObject description_json_object = description_json_document.object();

                QString text_description = description_json_object.value(QLatin1String("text")).toString();
                QString number_of_seeds = description_json_object.value(QLatin1String("number_of_seeds")).toString();
                QJsonArray peppers_array = description_json_object.value(QLatin1String("peppers")).toArray();

                emit addSeedsProductToModel(id.toInt(), name, type, price.toInt(), scoville.toInt(), text_description, number_of_seeds.toInt(), peppers_array);

            }

        }

    }

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

                name = json_message_object.value(QLatin1String("Name")).toString();
                phone_number = json_message_object.value(QLatin1String("Phone_number")).toString();
                emit loginSuccess(phone_number, name);

                GetActiveOrders();

            } else if (code_value.toString() == "403") {

                QJsonValue error_value = json_message_object.value(QLatin1String("Error_description"));
                emit showMessage("Oшибка логирования", error_value.toString());

            }

        } else if (resource_value.toString() == "Register_customer") {

            if (code_value.toString() == "200") {

                emit registerSuccess();

            } else if (code_value.toString() == "403") {

                QJsonValue error_description_value = json_message_object.value(QLatin1String("Error_description"));
                emit showMessage("Oшибка регистрации", error_description_value.toString());

            }

        } else if (resource_value.toString() == "Order") {

            if (code_value.toString() == "200") {

                size_t order_id = json_message_object.value(QLatin1String("order_id")).toInt();
                QString ordered_timestamp = json_message_object.value(QLatin1String("ordered_timestamp")).toString();
                QString receive_code = json_message_object.value(QLatin1String("receive_code")).toString();
                size_t total_cost = json_message_object.value(QLatin1String("total_cost")).toInt();
                QJsonArray order_data = json_message_object.value(QLatin1String("order_data")).toArray();
                bool is_ready = json_message_object.value(QLatin1String("is_ready")).toBool();

                emit orderAccepted();
                emit addActiveOrder(order_id, ordered_timestamp, receive_code, total_cost, order_data, is_ready);

            } else if (code_value.toString() == "403") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка заказа", error_description);

            } else if (code_value.toString() == "400") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка заказа", error_description);

            } else if (code_value.toString() == "500") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка заказа", error_description);

            }

        }

    } else if (method_value.toString() == "PUT") {

        if (resource_value.toString() == "Change_customer_name") {

            if (code_value.toString() == "200") {

                name = json_message_object.value(QLatin1String("New_name")).toString();
                emit changeNameSuccess(name);

            } else if (code_value.toString() == "403") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка смены имени", error_description);

            }

        } else if (resource_value.toString() == "Order_prepeared") {

            emit setOrderPrepeared(json_message_object.value(QLatin1String("Order_id")).toInt());

        }

    } else if (method_value.toString() == "DELETE") {

        if (resource_value.toString() == "Order") {

            if (code_value.toString() == "200") {

                emit cancelOrderAccepted(json_message_object.value(QLatin1String("Order_id")).toInt());

            } else if (code_value.toString() == "403") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка отмены заказа", error_description);

            }

        }

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Active_orders") {

            qDebug() << "Received active orders responce!";

            if (code_value.toString() == "200") {

                QJsonArray orders_array = json_message_object.value(QLatin1String("Orders")).toArray();
                qDebug() << QJsonDocument(orders_array).toJson();

                for (int i = 0; i < orders_array.size(); ++i) {

                    size_t order_id = orders_array[i].toObject().value("order_id").toInt();
                    QString ordered_timestamp = orders_array[i].toObject().value("ordered_timestamp").toString();
                    QString receive_code = orders_array[i].toObject().value("receive_code").toString();
                    size_t total_cost = orders_array[i].toObject().value("total_cost").toInt();
                    QString order_data_string = orders_array[i].toObject().value("order_data").toString();
                    bool is_ready = orders_array[i].toObject().value("is_ready").toBool();

                    QString ordered_timestamp_formated = ordered_timestamp.replace("T", " ");
                    ordered_timestamp_formated = ordered_timestamp_formated.left(16);

                    QJsonArray order_data_array = QJsonDocument::fromJson(order_data_string.toUtf8()).array();

                    emit addActiveOrder(order_id, ordered_timestamp_formated, receive_code,
                                        total_cost, order_data_array, is_ready);

                }


                GetReceivedOrders();


            } else if (code_value.toString() == "403") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка получения доставок", error_description);

            }

        } else if (resource_value.toString() == "Received_orders") {

            qDebug() << "Received received orders responce!";

            if (code_value.toString() == "200") {                

                QJsonArray orders_array = json_message_object.value(QLatin1String("Orders")).toArray();
                qDebug() << QJsonDocument(orders_array).toJson();

                for (int i = 0; i < orders_array.size(); ++i) {

                    size_t order_id = orders_array[i].toObject().value("order_id").toInt();
                    QString ordered_timestamp = orders_array[i].toObject().value("ordered_timestamp").toString();
                    QString received_timestamp = orders_array[i].toObject().value("received_timestamp").toString();
                    QString receive_code = orders_array[i].toObject().value("receive_code").toString();
                    size_t total_cost = orders_array[i].toObject().value("total_cost").toInt();
                    QString order_data_string = orders_array[i].toObject().value("order_data").toString();

                    QString ordered_timestamp_formated = ordered_timestamp.replace("T", " ");
                    ordered_timestamp_formated = ordered_timestamp_formated.left(16);
                    QString received_timestamp_formated = received_timestamp.replace("T", " ");
                    received_timestamp_formated = received_timestamp_formated.left(16);

                    QJsonArray order_data_array = QJsonDocument::fromJson(order_data_string.toUtf8()).array();

                    qDebug() << "Received order received_timestamp " << received_timestamp;
                    qDebug() << "Received order received_timestamp_formated " << received_timestamp_formated;

                    emit addReceivedOrder(order_id, ordered_timestamp_formated, received_timestamp_formated, receive_code, total_cost, order_data_array);

                }

            } else if (code_value.toString() == "403") {

                QString error_description = json_message_object.value(QLatin1String("Error_description")).toString();
                emit showMessage("Ошибка получения заказов", error_description);

            }

        } else if (resource_value.toString() == "Catalog") {

            if (code_value.toString() == "200") {

                qDebug() << "Get catalog!!";
                QJsonValue json_array_value = json_message_object.value(QLatin1String("Catalog"));
                QJsonObject obj = json_array_value.toObject();
                AddCatalogDataToModels(json_array_value.toArray());

            }

        }

    }

}

void Client::onChangeName(const QString &new_name) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Change_customer_name");
    message[QStringLiteral("Phone_number")] = phone_number;
    message[QStringLiteral("Name")] = new_name;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}

void Client::onDisconnected() {

    emit disconnected(QStringLiteral("Connection with the server was lost"));

}

void Client::onCancelOrder(const int &order_id, const QString& phone_number, const QString &receive_code) {

    qDebug() << "Trying send cancel order";

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("DELETE");
    message[QStringLiteral("Resource")] = QStringLiteral("Order");
    message[QStringLiteral("Order_id")] = order_id;
    message[QStringLiteral("Phone_number")] = phone_number;
    message[QStringLiteral("Receive_code")] = receive_code;
    QByteArray byte_array = QJsonDocument(message).toJson();
    byte_array.append("\n");

    qintptr bytes_written = socket->write(byte_array);
    qDebug() << bytes_written;

}
