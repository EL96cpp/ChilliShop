#include "server.h"

Server::Server() : sql_service(new SqlService(this))
{
    QThreadPool::globalInstance()->setMaxThreadCount(2);

    if (this->listen(QHostAddress::Any, 60000)) {

        qDebug() << "Server started!";

    } else {

    }

    catalog_byte_array = sql_service->GetCatalogData();

}

void Server::RespondToMessage(ClientConnection* client, QByteArray &message_byte_array)
{
    qDebug() << "server parses message!";
    MessageResponder* message_responder = new MessageResponder(client, message_byte_array, sql_service);

    QThreadPool::globalInstance()->start(message_responder);
}

void Server::incomingConnection(qintptr handle) {

    qDebug() << "new connection";
    ClientConnection* connection = new ClientConnection(this);
    connection->SetSocketDescriptor(handle);
    connect(connection, &ClientConnection::RespondToMessage, this, &Server::RespondToMessage);
    connections.push(std::move(connection));


}
