#ifndef MESSAGERESPONDER_H
#define MESSAGERESPONDER_H

#include <QRunnable>
#include <QObject>
#include <QString>
#include <QByteArray>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonObject>
#include <QRandomGenerator>

#include "sqlservice.h"
#include "clientconnection.h"

class MessageResponder : public QRunnable {

public:
    MessageResponder(ClientConnection* client, QByteArray& message_byte_array,
                     QByteArray& catalog_byte_array, SqlService* sql_service);

    void run();
    void RespondToCustomer(const QJsonObject& json_message_object);
    void RespondToEmployee(const QJsonObject& json_message_object);

    void LoginCustomer(const QString& phone_number, const QString& password);
    void RegisterCustomer(const QString& phone_number, const QString& password, const QString& name);
    void SendCatalog();
    void AddOrder(const QString& phone_number, const QString& timestamp, const QJsonValue& order_json);

private:
    QString GenerateOrderCode();


private:
    SqlService* sql_service;
    ClientConnection* client;
    QByteArray message_byte_array;
    QByteArray& catalog_byte_array;

};

#endif // MESSAGERESPONDER_H
