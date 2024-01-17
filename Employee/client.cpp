#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}, socket(new QTcpSocket) {

    connect(socket, &QTcpSocket::readyRead, this, &Client::onReadyRead);

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

    } else if (method_value.toString() == "GET") {

        if (resource_value.toString() == "Orders") {

            if (code_value.toString() == "200") {

                QJsonValue orders_data = json_message_object.value(QLatin1String("Orders"));


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

void Client::onPutOrderInProcess(const int &order_id) {

    QJsonObject message;
    message[QStringLiteral("Method")] = QStringLiteral("PUT");
    message[QStringLiteral("Resource")] = QStringLiteral("Processing_order");
    message[QStringLiteral("Order_id")] = order_id;
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
