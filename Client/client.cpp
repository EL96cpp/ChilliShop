#include "client.h"

Client::Client() : socket(new QSslSocket)
{}


void Client::ConnectToServer(const QString& address, const quint16& port) {

    socket->connectToHost(address, port);
    qDebug() << socket->state();
    if (socket->state() == QAbstractSocket::UnconnectedState) {

        qDebug() << "Connection error!";

    } else {

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

void Client::onMakeOrder(const QString &phone_number, const QString &order_datetime, const QJsonObject &order_data)
{

}

void Client::GetCatalog()
{

}

void Client::GetOrdersHistory()
{

}
