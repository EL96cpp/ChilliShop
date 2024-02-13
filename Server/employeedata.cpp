#include "employeedata.h"

EmployeeData::EmployeeData() {}

EmployeeData::EmployeeData(const QString& name,
                           const QString& surname,
                           const QString& position) : name(name), surname(surname), position(position) {}

bool EmployeeData::operator ==(const EmployeeData &other) const {

    return (other.name == name) && (other.surname == surname) && (other.position == position);

}
