#ifndef MESSAGERESPONDER_H
#define MESSAGERESPONDER_H

#include <QRunnable>
#include <QObject>
#include <QString>
#include <QVector>
#include <QByteArray>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonObject>
#include <QRandomGenerator>

#include "sqlservice.h"
#include "clientconnection.h"

class MessageResponder : public QObject, public QRunnable {

    Q_OBJECT
public:
    MessageResponder(QObject* parent, const QByteArray& message_byte_array,
                     const ConnectionType& connection_type, std::atomic<unsigned long long>& sql_connections_counter,
                     const bool& logged_in);
    ~MessageResponder();

    void run();
    void RespondToCustomer(const QJsonObject& json_message_object);
    void RespondToEmployee(const QJsonObject& json_message_object);

    void LoginCustomer(const QString& phone_number, const QString& password);
    void LoginEmployee(const QString& name, const QString& surname, const QString& position, const QString& password);
    void RegisterCustomer(const QString& phone_number, const QString& password, const QString& name);
    void AddOrder(const QString& phone_number, const QString& timestamp, const QJsonValue& order_json);

signals:
    void MessageResponce(const QByteArray& message_byte_array);
    void SetConnectionType(const ConnectionType& connection_type);
    void CheckIfOrderIsCorrect(const QVector<QString>& order_ids);

private:
    QString GenerateOrderCode();


private:
    QByteArray message_byte_array;
    ConnectionType connection_type;
    SqlService* sql_service = nullptr;
    std::atomic<unsigned long long>& sql_connections_counter;
    bool logged_in;
};

#endif // MESSAGERESPONDER_H
