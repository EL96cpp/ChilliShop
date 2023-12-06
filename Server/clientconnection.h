#ifndef CLIENTCONNECTION_H
#define CLIENTCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QByteArray>
#include <QThreadPool>

enum class ConnectionType {

    CUSTOMER,
    EMPLOYEE,
    UNKNOWN

};

class ClientConnection : public QObject
{
    Q_OBJECT
public:
    explicit ClientConnection(QObject *parent, std::atomic<unsigned long long>& sql_connections_counter);
    void SetSocketDescriptor(qintptr descriptor);
    void SetPhoneNumber(const QString& phone_number);
    void SetLoggedIn(const bool &logged_in);
    void SetConnectionType(const ConnectionType& connection_type);
    ConnectionType GetConnectionType();

    QString GetPhoneNumber();
    bool IsLoggedIn();

public slots:
    void OnMessageResponce(const QByteArray& message_byte_array);

private slots:
    void onReadyRead();

signals:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

private:
    QTcpSocket* socket;
    QString phone_number;
    ConnectionType connection_type;
    bool logged_in;
    std::atomic<unsigned long long>& sql_connections_counter;

};

#endif // CLIENTCONNECTION_H
