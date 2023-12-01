#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QObject>
#include <QThreadPool>
#include <QQueue>
#include <QMutexLocker>
#include <QVector>

#include "sqlservice.h"
#include "clientconnection.h"
#include "connectionsvector.h"
#include "messageresponder.h"
#include "product.h"
#include "order.h"

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server();

public slots:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

signals:
    void GetCatalogData(QVector<Product*>& catalog);

private:
    void incomingConnection(qintptr handle);


private:
    ConnectionsVector connections;
    QByteArray catalog_byte_array;
    SqlService* sql_service;

};

#endif // SERVER_H
