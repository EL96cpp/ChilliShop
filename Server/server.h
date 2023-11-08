#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QObject>

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server();

private:
    void incomingConnection(qintptr handle);

};

#endif // SERVER_H
