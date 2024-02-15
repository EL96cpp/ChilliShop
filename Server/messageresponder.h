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
#include "connectionsvector.h"
#include "clientconnection.h"
#include "employeedata.h"

class MessageResponder : public QObject, public QRunnable {

    Q_OBJECT
public:
    MessageResponder(QObject* parent, const QByteArray& message_byte_array, ConnectionsVector& connections, OrderIDVector& prepearing_order_ids,
                     OrderIDVector& issuing_order_ids, const ConnectionType& connection_type, std::atomic<unsigned long long>& sql_connections_counter,
                     const bool& logged_in, const QString& phone_number, const EmployeeData& employee_data);
    ~MessageResponder();

    void run();
    void RespondToCustomer(const QJsonObject& json_message_object);
    void RespondToEmployee(const QJsonObject& json_message_object);

    void LoginCustomer(const QString& phone_number, const QString& password);
    void LoginEmployee(const QString& name, const QString& surname, const QString& position, const QString& password);
    void RegisterCustomer(const QString& phone_number, const QString& password, const QString& name);
    void AddOrder(const QString& phone_number, const QString& timestamp, const int& total_cost, const QJsonValue& order_json);
    void AddReceivedOrder(const int& order_id, const QString& phone_number, const QString& ordered_timestamp,
                          const QString& received_timestamp, const QString& receive_code, const int& total_cost, const QMap<int, int>& order_data);

signals:
    void MessageResponce(const QByteArray& message_byte_array);
    void SetLoggedIn(const bool& logged_in);
    void SetCustomerData(const QString& phone_number, const QString& name);
    void SetEmployeeData(const EmployeeData& employee_data);
    void SendCatalog();
    void SetConnectionType(const ConnectionType& connection_type);
    void CheckIfOrderIsCorrect(const QVector<QString>& order_ids);
    void DeleteConnection();
    void SendToAllEmployees(const QByteArray& message_byte_array);
    void SendToAllEmployeesExceptOne(const QByteArray& message_byte_array, const EmployeeData& employee_data);
    void SendToCustomer(const QString& phone_number, const QByteArray& message_byte_array);

private:
    QString GenerateOrderCode();


private:
    QByteArray message_byte_array;
    QString phone_number;
    EmployeeData employee_data;
    ConnectionsVector& connections;
    OrderIDVector& prepearing_order_ids;
    OrderIDVector& issuing_order_ids;
    ConnectionType connection_type;
    SqlService* sql_service = nullptr;
    std::atomic<unsigned long long>& sql_connections_counter;
    bool logged_in;
};

#endif // MESSAGERESPONDER_H
