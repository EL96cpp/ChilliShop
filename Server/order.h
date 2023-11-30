#ifndef ORDER_H
#define ORDER_H

#include <QString>

class Order
{
public:
    Order(const int& id, const QString& phone_number, const QString& code);

    bool operator == (const Order& other);

private:
    int id;
    QString phone_number;
    QString code;

};

#endif // ORDER_H
