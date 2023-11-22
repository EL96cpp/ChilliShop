#ifndef SQLSERVICE_H
#define SQLSERVICE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlError>
#include <QMutex>
#include <QMutexLocker>

enum class CustomerLoginResult {

    SUCCESS,
    NO_PHONE_IN_DATABASE,
    INCORRECT_PASSWORD

};

enum class EmployeeLoginResult {

    SUCCESS,
    NO_EMPLOYEE_IN_DATABASE,
    INCORRECT_PASSWORD

};

enum class RegisterResult {

    SUCCESS,
    PHONE_ALREADY_REGISTERED

};

class SqlService : public QObject
{
    Q_OBJECT
public:
    explicit SqlService(QObject *parent = nullptr);
    QString GetCustomerName(const QString& phone_number);

signals:

private:
    CustomerLoginResult CheckLoginCustomer(const QString& phone_number, const QString& password);
    EmployeeLoginResult CheckLoginEmployee(const QString& name, const QString& position, const QString& password);

private:
    QSqlDatabase sql_database;
    QMutex mutex;

};

#endif // SQLSERVICE_H
