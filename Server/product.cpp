#include "product.h"

Product::Product(const QString &id,
                 const QString &type,
                 const QString &name,
                 const QString &price,
                 const QString &scoville,
                 const QString &description) : id(id), type(type),
    name(name), price(price),
    scoville(scoville), description(description) {}

QString Product::GetId() {

    return id;

}

QString Product::GetType() {

    return type;

}

QString Product::GetName() {

    return name;

}

QString Product::GetPrice()
{
    return price;
}

QString Product::GetScoville()
{
    return scoville;
}

QString Product::GetDescription()
{
    return description;
}
