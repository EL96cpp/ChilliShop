#ifndef CLIENT_H
#define CLIENT_H

#include <QTcpSocket>
#include <QObject>
#include <QJsonObject>

class Client : public QObject
{
    Q_OBJECT
public:
    Client();

private:

    void ConnectToServer(const QString& address, const quint16& port);
    void Login(const QString& phone_number, const QString& password);
    void Register(const QString& phone_number, const QString& password, const QString& name);
    void MakeOrder(const QString& phone_number, const QString& order_datetime, const QJsonObject& order_data);
    void GetCatalog();

private:
    QTcpSocket* socket;

};

#endif // CLIENT_H
