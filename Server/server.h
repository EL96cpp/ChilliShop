#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>
#include <QObject>

class Server : public QTcpServer
{
    Q_OBJECT
public:
    Server();
};

#endif // SERVER_H
