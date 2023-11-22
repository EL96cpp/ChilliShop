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

#include "sqlservice.h"
#include "clientconnection.h"

class MessageResponder : public QObject, public QRunnable
{
    Q_OBJECT
public:
    MessageResponder(ClientConnection* client, QByteArray& message_byte_array, SqlService* sql_service);

    void run();
    void RespondToCustomer(const QJsonObject& json_message_object);
    void RespondToEmployee(const QJsonObject& json_message_object);

private:
    SqlService* sql_service;
    ClientConnection* client;
    QByteArray message_byte_array;

};

#endif // MESSAGERESPONDER_H
