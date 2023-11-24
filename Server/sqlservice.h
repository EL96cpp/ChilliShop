#ifndef SQLSERVICE_H
#define SQLSERVICE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlError>
#include <QMutex>
#include <QMutexLocker>
#include <QByteArray>
#include <QUrl>
#include <QImage>
#include <QBuffer>
#include <QJsonObject>

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
    QByteArray GetCatalogData();

signals:

private:
    CustomerLoginResult CheckLoginCustomer(const QString& phone_number, const QString& password);
    EmployeeLoginResult CheckLoginEmployee(const QString& name, const QString& position, const QString& password);
    void AddOrder();
    void CancelOrder();
    void CreateTablesIfNotExists();

private:
    QSqlDatabase sql_database;
    QMutex mutex;

};

#endif // SQLSERVICE_H
