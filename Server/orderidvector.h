#ifndef ORDERIDVECTOR_H
#define ORDERIDVECTOR_H

#include <QVector>
#include <QMutex>
#include <QMutexLocker>
#include <QDebug>

class OrderIDVector
{
public:
    OrderIDVector();

    bool push(const int& id);
    bool erase(const int& id);

private:
    QVector<int> ids_vector;
    QMutex mutex;

};

#endif // ORDERIDVECTOR_H
