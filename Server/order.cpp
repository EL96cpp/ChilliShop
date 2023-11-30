#include "order.h"

Order::Order(const int &id,
             const QString &phone_number,
             const QString &code) : id(id), phone_number(phone_number), code(code) {}

bool Order::operator == (const Order &other)
{
    return (other.id == id && other.phone_number == phone_number && other.code == code);
}
