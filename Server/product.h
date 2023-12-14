#ifndef PRODUCT_H
#define PRODUCT_H

#include <QString>

class Product
{
public:
    Product(const QString& id, const QString& type, const QString& name,
            const QString& price, const QString& scoville, const QString& description);

    QString GetId();
    QString GetType();
    QString GetName();
    QString GetPrice();
    QString GetScoville();
    QString GetDescription();

private:
    QString id;
    QString type;
    QString name;
    QString price;
    QString scoville;
    QString description;


};

#endif // PRODUCT_H
