#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QString>
#include <QMap>
#include <QJsonParseError>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);

    void ConnectToServer(const QString& address, const quint16& port);

signals:
    void removeOrder(const int& order_id);
    void errorOccurred(const QString& title, const QString& description);
    void loggedIn(const QString& name, const QString& surname, const QString& position);
    void addOrderToView(const int& order_id, const QString& name, const QString& phone,
                        const QString& order_code, const QMap<int, int>& order_data,
                        const int& total_cost);
    void showErrorMessage(const QString& error_title, const QString& error_description);

    void putOrderInProcessSuccess();
    void putOrderInProcessError(const QString& error_description);

public slots:
    void onLogin(const QString& name, const QString& surname,
                 const QString& position, const QString& password);
    void onReadyRead();
    void onPutOrderInProcess(const int& order_id);
    void deleteConnection();

private:
    void SendConnectionType();
    void GetOrders();
    void GetCatalog();

private:
    QTcpSocket* socket;
    QString name;
    QString surname;
    QString position;

};

#endif // CLIENT_H
