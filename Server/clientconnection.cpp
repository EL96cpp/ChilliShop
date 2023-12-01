#include "clientconnection.h"

ClientConnection::ClientConnection(QObject *parent)
    : QObject(parent), socket(new QTcpSocket), connection_type(ConnectionType::UNKNOWN),
      logged_in(false) {

    connect(socket, &QTcpSocket::readyRead, this, &ClientConnection::onReadyRead);
    qDebug() << "new connection connected socket readyread!";

}

void ClientConnection::SetSocketDescriptor(qintptr descriptor) {

    socket->setSocketDescriptor(descriptor);

}

void ClientConnection::SetPhoneNumber(const QString &phone_number) {

    this->phone_number = phone_number;

}

void ClientConnection::SetLoggedIn(const bool &logged_in)
{
    this->logged_in = logged_in;
}

void ClientConnection::SetConnectionType(const ConnectionType &connection_type) {

    this->connection_type = connection_type;

}

ConnectionType ClientConnection::GetConnectionType() {

    return connection_type;

}

void ClientConnection::SendMessage(const QByteArray &message_byte_array)
{
    socket->write(message_byte_array);
}

QString ClientConnection::GetPhoneNumber()
{
    return phone_number;
}

bool ClientConnection::IsLoggedIn()
{
    return logged_in;
}

void ClientConnection::onReadyRead() {

    QByteArray message_byte_array = socket->readAll();
    emit RespondToMessage(this, message_byte_array);

}

