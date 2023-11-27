#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}, socket(new QSslSocket)
{

}

void Client::ConnectToServer(const QString& address, const quint16& port) {

    socket->connectToHost(address, port);
    qDebug() << socket->state();
    if (socket->state() == QAbstractSocket::UnconnectedState) {

        qDebug() << "Connection error!";

    } else {

        qDebug() << "Connected!";

    }

}

void Client::onLogin(const QString &name, const QString &surname,
                     const QString& position, const QString &password) {



}

void Client::getOrders()
{

}
