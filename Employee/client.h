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

    void addOrderToOrederIssuingModel(const int& order_id, const QString& ordered_timestamp, const QString& receive_code,
                                      const QString& phone_number, const int& total_cost, const QJsonArray& order_data);
    void addOrderToOrderPrepearingModel(const int& order_id, const QString& phone_number, const QString& receive_code, const QString& ordered_timestamp, const int& total_cost, const QJsonArray& order_data);
    void startPrepearingOrderConfirmed(const int& order_id);
    void startIssuingOrderConfirmed(const int& order_id);
    void stopPrepearingOrderConfirmed();
    void stopIssuingOrderConfirmed();
    void orderPrepearedConfirmed(const int& order_id);
    void setOrderPrepeared(const int& order_id);
    void orderReceivedConfirmed(const int& order_id, const QString& phone_number, const QString& receive_code);
    void showErrorMessage(const QString& error_title, const QString& error_description);

public slots:
    void onLogin(const QString& name, const QString& surname,
                 const QString& position, const QString& password);
    void onReadyRead();
    void onStartPrepearingOrder(const int& order_id);
    void onStartIssuingOrder(const int& order_id);
    void onStopPrepearingOrder(const int& order_id);
    void onStopIssuingOrder(const int& order_id);
    void onOrderPrepearedMessage(const int& order_id, const QString& phone_number, const QString& receive_code);
    void onOrderReceivedMessage(const int& order_id, const QString& phone_number, const QString& receive_code);
    void deleteConnection();
    void onDisconnected();

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
