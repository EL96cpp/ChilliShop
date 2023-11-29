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

enum class CustomerRegisterResult {

    SUCCESS,
    PHONE_ALREADY_REGISTERED

};

class SqlService : public QObject
{
    Q_OBJECT
public:
    explicit SqlService(QObject *parent = nullptr);

    // Following fucntions must be thread-safe!
    QByteArray GetCatalogData();
    QString GetCustomerName(const QString& phone_number);
    CustomerLoginResult LoginCustomer(const QString& phone_number, const QString& password);
    CustomerRegisterResult RegisterCustomer(const QString& phone_number, const QString& password, const QString& name);
    bool CheckIfPhoneNumberExists(const QString& phone_number);
    bool CheckIfEmployeeExists(const QString& name, const QString& surname, const QString& position);
    bool AddOrder(const QString& phone_number, const QJsonArray& order_array, const QString& order_code);
    bool CheckIfOrderExists(const QString& phone_number, const int& order_id);
    bool CancelOrder(const QString& phone_number, const int& order_id);

private:

    void CreateTablesIfNotExists();

private:
    QSqlDatabase sql_database;
    QMutex mutex;

};

#endif // SQLSERVICE_H
