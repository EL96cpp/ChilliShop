#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QSslSocket>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);

signals:

private:
    QSslSocket socket;

};

#endif // CLIENT_H
