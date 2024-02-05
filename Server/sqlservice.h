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
#include <QJsonArray>
#include <QJsonDocument>
#include <QFile>
#include <QVector>

#include "product.h"

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

enum class AddReceivedOrderResult {

    SUCCESS,
    NO_ORDER_IN_DATABASE,
    INCORRECT_PRODUCT_ID

};

class SqlService {

public:
    explicit SqlService(const QString& sql_connections_counter);

    // Following fucntions must be thread-safe!
    QJsonArray GetCatalogData();
    QJsonArray GetCustomerActiveOrders(const QString& phone_number);
    QJsonArray GetCustomerReceivedOrders(const QString& phone_number);
    QString GetCustomerName(const QString& phone_number);
    CustomerLoginResult LoginCustomer(const QString& phone_number, const QString& password);
    CustomerRegisterResult RegisterCustomer(const QString& phone_number, const QString& password, const QString& name);
    EmployeeLoginResult LoginEmployee(const QString& name, const QString& surname, const QString& position, const QString& password);
    bool CheckIfPhoneNumberExists(const QString& phone_number);
    bool CheckIfEmployeeExists(const QString& name, const QString& surname, const QString& position);
    int AddOrder(const QString& phone_number, const QString& timestamp, const int& total_cost, const QJsonArray& order_array, const QString& order_code);
    bool CheckIfOrderIsCorrect(const QVector<int>& product_ids);
    bool CheckIfOrderExists(const int& order_id, const QString& phone_number, const QString& receive_code);
    bool CheckIfOrderExists(const int& order_id);
    bool CancelOrder(const int &order_id, const QString &phone_number, const QString &receive_code);
    bool ChangeCustomerName(const QString& phone_number, const QString& new_name);
    AddReceivedOrderResult AddReceivedOrder(const int& order_id, const QString& phone_number, const QString& ordered_timestamp, const QString& received_timestamp, const QString& receive_code, const int& total_cost, const QMap<int, int>& order_data);

    void CreateTablesIfNotExists();

private:
    QSqlDatabase sql_database;

};

#endif // SQLSERVICE_H
