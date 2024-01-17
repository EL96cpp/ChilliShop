#ifndef CLIENTCONNECTION_H
#define CLIENTCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QByteArray>
#include <QThreadPool>

#include "orderidvector.h"

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
                              OrderIDVector& processing_ids,
                              std::atomic<unsigned long long>& sql_connections_counter,
                              const QByteArray& catalog_byte_array);
    void SetSocketDescriptor(qintptr descriptor);
    void SetEmployeeData(const QString& name, const QString& surname, const QString& position);
    void SetLoggedIn(const bool &logged_in);
    void SetConnectionType(const ConnectionType& connection_type);
    ConnectionType GetConnectionType();

    QString GetPhoneNumber();
    bool IsLoggedIn();

public slots:
    void OnSetCustomerData(const QString& phone_number, const QString& name);
    void OnMessageResponce(const QByteArray& message_byte_array);
    void OnSendCatalog();
    void OnSetLoggedIn(const bool& logged_in);

private slots:
    void onReadyRead();

signals:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

private:
    QTcpSocket* socket;
    ConnectionsVector& connections;
    OrderIDVector& processing_ids;
    const QByteArray& catalog_byte_array;
    QString phone_number;
    QString name;
    QString surname;
    QString position;
    ConnectionType connection_type;
    bool logged_in;
    std::atomic<unsigned long long>& sql_connections_counter;

};

#endif // CLIENTCONNECTION_H
