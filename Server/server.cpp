#include "server.h"

Server::Server() : sql_connections_counter(0) {

    QThreadPool::globalInstance()->setMaxThreadCount(10);
    SetCatalogMessageByteArray();

    if (this->listen(QHostAddress::Any, 60000)) {

        qDebug() << "Server started!";

    } else {

    }

}

void Server::RespondToMessage(ClientConnection* client, QByteArray &message_byte_array) {

    qDebug() << "server parses message!";

}

void Server::onOrderPrepeared(const int &order_id, const QString &phone_number) {



}

void Server::onOrderReceived(const int &order_id, const QString &phone_number) {



}


void Server::incomingConnection(qintptr handle) {

    qDebug() << "new connection";
    ClientConnection* connection = new ClientConnection(this, connections, prepearing_order_ids, issuing_order_ids,
                                                        sql_connections_counter, catalog_message_byte_array);
    connection->SetSocketDescriptor(handle);
    connect(connection, &ClientConnection::RespondToMessage, this, &Server::RespondToMessage);
    connections.push(std::move(connection));

}

void Server::SetCatalogMessageByteArray() {

    SqlService* sql_service = new SqlService(QStringLiteral("server_connection"));

    QJsonArray catalog_array = sql_service->GetCatalogData();

    QJsonObject message;
    message[QLatin1String("Method")] = QStringLiteral("GET");
    message[QLatin1String("Resource")] = QStringLiteral("Catalog");
    message[QLatin1String("Code")] = QStringLiteral("200");
    message[QLatin1String("Catalog")] = QJsonValue(catalog_array);

    catalog_message_byte_array = QJsonDocument(message).toJson();

}
