#ifndef CLIENT_H
#define CLIENT_H

#include <QTcpSocket>
#include <QObject>

class Client : public QObject
{
    Q_OBJECT
public:
    Client();

    void ConnectToServer(const QString& address, const quint16& port);
    void Login(const QString& phone_number, const QString& password);

private:
    QTcpSocket* socket;

};

#endif // CLIENT_H
