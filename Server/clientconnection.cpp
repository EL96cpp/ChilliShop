#include "clientconnection.h"
#include "connectionsvector.h"
#include "messageresponder.h"

ClientConnection::ClientConnection(QObject *parent, ConnectionsVector& connections, OrderIDVector& prepearing_order_ids,
                                   OrderIDVector& issuing_order_ids, std::atomic<unsigned long long>& sql_connections_counter,
                                   const QByteArray& catalog_byte_array) : QObject(parent),
                                                                           connections(connections),
                                                                           prepearing_order_ids(prepearing_order_ids),
                                                                           issuing_order_ids(issuing_order_ids),
                                                                           socket(new QTcpSocket),
                                                                           sql_connections_counter(sql_connections_counter),
                                                                           connection_type(ConnectionType::UNKNOWN),
                                                                           logged_in(false),
                                                                           catalog_byte_array(catalog_byte_array) {

    connect(socket, &QTcpSocket::readyRead, this, &ClientConnection::onReadyRead);
    qDebug() << "new connection connected socket readyread!";

}

void ClientConnection::SetSocketDescriptor(qintptr descriptor) {

    socket->setSocketDescriptor(descriptor);

}

void ClientConnection::OnSetCustomerData(const QString &phone_number, const QString& name) {

    qDebug() << "set customer data " << phone_number << " " << name;

    this->phone_number = phone_number;
    this->name = name;

}

void ClientConnection::SetEmployeeData(const QString &name, const QString &surname, const QString &position) {

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

void ClientConnection::OnSendCatalog() {

    qDebug() << socket->write(catalog_byte_array);
    qDebug() << "Sent catalog data!!";

}

void ClientConnection::OnSetLoggedIn(const bool &logged_in) {

    this->logged_in = logged_in;

}

void ClientConnection::OnMessageResponce(const QByteArray &message_byte_array) {

    qDebug() << message_byte_array;
    qDebug() << socket->write(message_byte_array);

}

QString ClientConnection::GetPhoneNumber() {

    return phone_number;

}

bool ClientConnection::CheckIfEmployeeDataIsEqual(const QString &name, const QString &surname, const QString &position) {

    return (this->name == name && this->surname == surname && this->position == position);

}

bool ClientConnection::IsLoggedIn() {

    return logged_in;

}

void ClientConnection::onReadyRead() {

    QByteArray message_byte_array = socket->readAll();
    MessageResponder* message_responder = new MessageResponder(this, message_byte_array, connections, prepearing_order_ids, issuing_order_ids,
                                                               connection_type, sql_connections_counter, logged_in, phone_number);

    connect(message_responder, &MessageResponder::SetConnectionType, this, &ClientConnection::SetConnectionType, Qt::DirectConnection);
    connect(message_responder, &MessageResponder::MessageResponce, this, &ClientConnection::OnMessageResponce);
    connect(message_responder, &MessageResponder::SendCatalog, this, &ClientConnection::OnSendCatalog);
    connect(message_responder, &MessageResponder::SetLoggedIn, this, &ClientConnection::OnSetLoggedIn);
    connect(message_responder, &MessageResponder::SetCustomerData, this, &ClientConnection::OnSetCustomerData);

    QThreadPool::globalInstance()->start(message_responder);

}

