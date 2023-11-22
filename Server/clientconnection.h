#ifndef CLIENTCONNECTION_H
#define CLIENTCONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QByteArray>

enum class ConnectionType {

    CUTOMER,
    EMPLOYEE,
    UNKNOWN

};

class ClientConnection : public QObject
{
    Q_OBJECT
public:
    explicit ClientConnection(QObject *parent);
    void SetSocketDescriptor(qintptr descriptor);
    void SetPhoneNumber(const QString& phone_number);
    void SetConnectionType(const ConnectionType& connection_type);
    ConnectionType GetConnectionType();

private slots:
    void onReadyRead();

signals:
    void RespondToMessage(ClientConnection* client, QByteArray& message_byte_array);

private:
    QTcpSocket* socket;
    QString phone_number;
    ConnectionType connection_type;

};

#endif // CLIENTCONNECTION_H
