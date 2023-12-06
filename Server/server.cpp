#include "server.h"

Server::Server() : sql_connections_counter(0) {

    QThreadPool::globalInstance()->setMaxThreadCount(10);

    if (this->listen(QHostAddress::Any, 60000)) {

        qDebug() << "Server started!";

    } else {

    }

}

void Server::RespondToMessage(ClientConnection* client, QByteArray &message_byte_array) {

    qDebug() << "server parses message!";

}

void Server::incomingConnection(qintptr handle) {

    qDebug() << "new connection";
    ClientConnection* connection = new ClientConnection(this, sql_connections_counter);
    connection->SetSocketDescriptor(handle);
    connect(connection, &ClientConnection::RespondToMessage, this, &Server::RespondToMessage);
    connections.push(std::move(connection));

}
