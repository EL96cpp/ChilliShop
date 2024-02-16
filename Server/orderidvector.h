#ifndef ORDERIDVECTOR_H
#define ORDERIDVECTOR_H

#include <QVector>
#include <QMutex>
#include <QMutexLocker>
#include <QDebug>
#include <QJsonArray>
#include <map>

#include "employeedata.h"

class OrderIDVector
{
public:
    OrderIDVector();

    bool push(const EmployeeData& employee_data, const int& id);
    bool erase(const EmployeeData& employee_data, const int& id);
    void removeAllEmployeeIDs(const EmployeeData& employee_data);
    QJsonArray getAllOrderIDs();

private:
    QVector<std::pair<EmployeeData, int>> ids_vector;
    QMutex mutex;

};

#endif // ORDERIDVECTOR_H
