#include "client.h"

Client::Client() : socket(new QTcpSocket)
{



}


void Client::ConnectToServer(const QString& address, const quint16& port) {

    socket->connectToHost(address, port);
    if (socket->state() != QAbstractSocket::ConnectedState) {

        emit ConnectionError();

    } else {

        qDebug() << "Connected!";

    }

}

void Client::Login(const QString& phone_number, const QString& password) {



}


void Client::Register(const QString& phone_number, const QString& password, const QString& name) {



}

void Client::MakeOrder(const QString &phone_number, const QString &order_datetime, const QJsonObject &order_data)
{

}

void Client::GetCatalog()
{

}
