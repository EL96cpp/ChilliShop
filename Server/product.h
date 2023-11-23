#ifndef PRODUCT_H
#define PRODUCT_H

#include <QString>
#include <QJsonObject>
#include <QPixmap>

class Product
{
public:
    explicit Product();

private:
    int id;
    QString name;
    int price;
    int scoville;
    QPixmap image;
    QJsonObject description;

};

#endif // PRODUCT_H
