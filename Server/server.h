#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QObject>
#include <QThreadPool>
#include <QQueue>
#include <QMutexLocker>
#include <QVector>

#include <QString>

#include "clientconnection.h"
#include "connectionsvector.h"
#include "messageresponder.h"
#include "product.h"
#include "order.h"
#include "orderidvector.h"
#include "sqlservice.h"

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server();

public slots:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

private:
    void incomingConnection(qintptr handle);
    void SetCatalogMessageByteArray();


private:
    ConnectionsVector connections;
    OrderIDVector processing_ids;
    OrderIDVector issuing_ids;
    QByteArray catalog_message_byte_array;
    std::atomic<unsigned long long> sql_connections_counter;

};

#endif // SERVER_H
