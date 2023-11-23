#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QSslSocket>
#include <QString>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);

public slots:
    void onLogin(const QString& name, const QString& surname, const QString& password);

private:
    void getOrders();

private:
    QSslSocket socket;

};

#endif // CLIENT_H
