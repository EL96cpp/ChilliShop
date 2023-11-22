#ifndef CONNECTIONSVECTOR_H
#define CONNECTIONSVECTOR_H

#include <QVector>
#include <QMutex>
#include <QMutexLocker>
#include <QDebug>

#include "clientconnection.h"

class ConnectionsVector
{
public:
    ConnectionsVector();
    void push(ClientConnection* client_connection);
    void erase(ClientConnection* client_connection);

private slots:



private:
    QVector<ClientConnection*> connections;
    QMutex mutex;

};

#endif // CONNECTIONSVECTOR_H
