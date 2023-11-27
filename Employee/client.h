#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QSslSocket>
#include <QString>
#include <QMap>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);

    void ConnectToServer(const QString& address, const quint16& port);

signals:
    void AddOrderToView(const int& order_id, const QString& name, const QString& phone,
                        const QString& order_code, const QMap<int, int>& order_data,
                        const int& total_cost);

public slots:
    void onLogin(const QString& name, const QString& surname,
                 const QString& position, const QString& password);

private:
    void getOrders();

private:
    QSslSocket* socket;


};

#endif // CLIENT_H
