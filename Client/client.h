#ifndef CLIENT_H
#define CLIENT_H

#include <QSslSocket>
#include <QObject>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument>
#include <QJsonArray>
#include <QByteArray>

class Client : public QObject
{
    Q_OBJECT
public:
    Client();
    void ConnectToServer(const QString& address, const quint16& port);

signals:
    void AddProductToGrid(const QString& product_type, const int& id, const QString& name,
                          const int& price, const int& scoville, const QImage& image);

public slots:
    void onLogin(const QString& phone_number, const QString& password);
    void onRegister(const QString& phone_number, const QString& password, const QString& name);
    void onMakeOrder(const QString& phone_number, const QString& order_datetime, const QJsonObject& order_data);

private:
    void SendConnectionType();
    void GetCatalog();
    void GetOrdersHistory();

private:
    QSslSocket* socket;
    QString phone_number;
    QString name;

};

#endif // CLIENT_H
