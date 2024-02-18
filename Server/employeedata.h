#ifndef EMPLOYEEDATA_H
#define EMPLOYEEDATA_H

#include <QString>
#include <QDebug>

class EmployeeData {

public:
    EmployeeData();
    EmployeeData(const QString& name, const QString& surname, const QString& position);

    void Debug() const;

    bool operator == (const EmployeeData& other) const;
    bool operator != (const EmployeeData& other) const;
    void clear();

private:
    QString name;
    QString surname;
    QString position;

};

#endif // EMPLOYEEDATA_H
