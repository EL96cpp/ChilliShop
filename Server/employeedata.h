#ifndef EMPLOYEEDATA_H
#define EMPLOYEEDATA_H

#include <QString>

class EmployeeData {

public:
    EmployeeData();
    EmployeeData(const QString& name, const QString& surname, const QString& position);

    bool operator == (const EmployeeData& other) const;

private:
    QString name;
    QString surname;
    QString position;

};

#endif // EMPLOYEEDATA_H
