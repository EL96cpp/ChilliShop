#include "connectionsvector.h"

ConnectionsVector::ConnectionsVector()
{

}

void ConnectionsVector::push(ClientConnection *client_connection)
{
    QMutexLocker locker(&mutex);
    connections.push_back(client_connection);
    qDebug() << "new connection added to vector " << connections.size();

}

void ConnectionsVector::erase(ClientConnection *client_connection)
{
    QMutexLocker locker(&mutex);
    connections.erase(std::remove(connections.begin(), connections.end(), client_connection), connections.end());
}
