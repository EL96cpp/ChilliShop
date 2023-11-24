#include "product.h"

Product::Product(const int& id, const QString& name, const int& price, const int& scoville,
                 const QPixmap& image, const QJsonObject& description) : id(id), name(name),
                                                                         price(price),
                                                                         scoville(scoville),
                                                                         image(image),
                                                                         description(description) {}
