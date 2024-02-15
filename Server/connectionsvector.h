#ifndef CONNECTIONSVECTOR_H
#define CONNECTIONSVECTOR_H

#include <QObject>
#include <QVector>
#include <QMutex>
#include <QMutexLocker>
#include <QDebug>

#include "clientconnection.h"

class ConnectionsVector : public QObject {
public:
    ConnectionsVector(QObject* parent = nullptr);
    void push(ClientConnection* client_connection);
    void erase(ClientConnection* client_connection);

    bool CheckIfCustomerAlreadyLogged(const QString& phone_number);
    bool CheckIfEmployeeAlreadyLogged(const QString& name, const QString& surname, const QString& position);

public slots:
    void onSendToAllEmployees(const QByteArray& message_byte_array);
    void onSendToAllEmployeesExceptOne(const QByteArray& message_byte_array, const EmployeeData& employee_data);
    void onSendToCustomer(const QString& phone_number, const QByteArray& message_byte_array);


private:
    QVector<ClientConnection*> connections;
    QMutex mutex;

};

#endif // CONNECTIONSVECTOR_H
