#ifndef CLIENTCONNECTION_H
#define CLIENTCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QByteArray>
#include <QThreadPool>

#include "orderidvector.h"
#include "employeedata.h"

class ConnectionsVector;

enum class ConnectionType {

    CUSTOMER,
    EMPLOYEE,
    UNKNOWN

};

class ClientConnection : public QObject
{
    Q_OBJECT
public:
    explicit ClientConnection(QObject *parent, ConnectionsVector& connections,
                              OrderIDVector& prepearing_order_ids,
                              OrderIDVector& issuing_order_ids,
                              std::atomic<unsigned long long>& sql_connections_counter,
                              const QByteArray& catalog_byte_array);

    void SetSocketDescriptor(qintptr descriptor);
    void SetLoggedIn(const bool &logged_in);
    void SetConnectionType(const ConnectionType& connection_type);
    ConnectionType GetConnectionType();
    void SendMessage(const QByteArray& message_byte_array);

    QString GetPhoneNumber();
    EmployeeData GetEmployeeData();
    bool CheckIfEmployeeDataIsEqual(const EmployeeData& employee_data);
    bool IsLoggedIn();

public slots:
    void OnSetCustomerData(const QString& phone_number, const QString& name);
    void OnSetEmployeeData(const EmployeeData& employee_data);
    void OnMessageResponce(const QByteArray& message_byte_array);
    void OnSendCatalog();
    void OnSetLoggedIn(const bool& logged_in);
    void OnSetLoggedOut();

private slots:
    void onReadyRead();

signals:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

private:
    QTcpSocket* socket;
    ConnectionsVector& connections;
    OrderIDVector& prepearing_order_ids;
    OrderIDVector& issuing_order_ids;
    const QByteArray& catalog_byte_array;
    QString phone_number;
    QString name;
    EmployeeData employee_data;
    ConnectionType connection_type;
    bool logged_in;
    std::atomic<unsigned long long>& sql_connections_counter;

};

#endif // CLIENTCONNECTION_H
