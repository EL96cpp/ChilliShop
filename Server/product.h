#ifndef PRODUCT_H
#define PRODUCT_H

#include <QString>
#include <QJsonObject>
#include <QPixmap>

class Product
{
public:
    explicit Product(const int& id, const QString& name, const int& price, const int& scoville,
                     const QPixmap& image, const QJsonObject& description);

private:
    int id;
    QString name;
    int price;
    int scoville;
    QPixmap image;
    QJsonObject description;

};

#endif // PRODUCT_H
