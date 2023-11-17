#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QObject>

#include "sqlservice.h"

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server();

private:
    void incomingConnection(qintptr handle);

private:
    SqlService* sql_service;

};

#endif // SERVER_H
