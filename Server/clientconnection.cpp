#include "clientconnection.h"
#include "connectionsvector.h"
#include "messageresponder.h"

ClientConnection::ClientConnection(QObject *parent, ConnectionsVector& connections, std::atomic<unsigned long long>& sql_connections_counter)
    : QObject(parent), connections(connections), socket(new QTcpSocket), sql_connections_counter(sql_connections_counter),
      connection_type(ConnectionType::UNKNOWN), logged_in(false) {

    connect(socket, &QTcpSocket::readyRead, this, &ClientConnection::onReadyRead);
    qDebug() << "new connection connected socket readyread!";

}

void ClientConnection::SetSocketDescriptor(qintptr descriptor) {

    socket->setSocketDescriptor(descriptor);

}

void ClientConnection::SetPhoneNumber(const QString &phone_number) {

    this->phone_number = phone_number;

}

void ClientConnection::SetEmployeeData(const QString &name, const QString &surname, const QString &position)
{
    this->name = name;
    this->surname = surname;
    this->position = position;
}

void ClientConnection::SetLoggedIn(const bool &logged_in) {

    this->logged_in = logged_in;

}

void ClientConnection::SetConnectionType(const ConnectionType &connection_type) {

    this->connection_type = connection_type;

}

ConnectionType ClientConnection::GetConnectionType() {

    return connection_type;

}

void ClientConnection::OnMessageResponce(const QByteArray &message_byte_array) {

    qDebug() << message_byte_array;
    qDebug() << socket->write(message_byte_array);

}

QString ClientConnection::GetPhoneNumber() {

    return phone_number;

}

bool ClientConnection::IsLoggedIn() {

    return logged_in;

}

void ClientConnection::onReadyRead() {

    QByteArray message_byte_array = socket->readAll();
    MessageResponder* message_responder = new MessageResponder(this, message_byte_array, connection_type, sql_connections_counter, logged_in);

    connect(message_responder, &MessageResponder::SetConnectionType, this, &ClientConnection::SetConnectionType, Qt::DirectConnection);
    connect(message_responder, &MessageResponder::MessageResponce, this, &ClientConnection::OnMessageResponce);

    QThreadPool::globalInstance()->start(message_responder);

}

