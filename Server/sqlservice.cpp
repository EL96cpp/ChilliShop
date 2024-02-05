#include "sqlservice.h"

SqlService::SqlService(const QString& sql_connections_counter) : sql_database(QSqlDatabase::addDatabase("QPSQL", sql_connections_counter)) {

    sql_database.setHostName("127.0.0.1");
    sql_database.setPort(5432);
    sql_database.setDatabaseName("chilli_shop");
    sql_database.setUserName("postgres");
    sql_database.setPassword("postgres");

    qDebug() << sql_database.databaseName() << " name";
    qDebug() << sql_database.connectionName() << " name";

    if (sql_database.open()) {

        CreateTablesIfNotExists();
        qDebug() << "Databse opened!";

    } else {

        qDebug() << "Postgres database connection error!";

    }

}


QString SqlService::GetCustomerName(const QString &phone_number) {

    QSqlQuery get_name_query(sql_database);
    get_name_query.prepare("SELECT name FROM customers WHERE phone_number = (?)");
    get_name_query.addBindValue(phone_number);
    get_name_query.exec();

    while (get_name_query.next()) {

        return get_name_query.value(0).toString();

    }

}

CustomerLoginResult SqlService::LoginCustomer(const QString &phone_number, const QString &password) {

    if (!CheckIfPhoneNumberExists(phone_number)) {

        return CustomerLoginResult::NO_PHONE_IN_DATABASE;

    }

    QSqlQuery login_customer_query(sql_database);
    login_customer_query.prepare("SELECT password FROM cutomers WHERE phone_number = (?)");
    login_customer_query.addBindValue(phone_number);
    login_customer_query.exec();

    while (login_customer_query.next()) {

        QString correct_password = login_customer_query.value(0).toString();

        qDebug() << phone_number << " phone number will check password";
        qDebug() << password << " " << correct_password << " passwords";

        // compare method returns 0, if two strings are equal!
        if (!correct_password.compare(password, Qt::CaseSensitive)) {

            return CustomerLoginResult::SUCCESS;

        } else {

            return CustomerLoginResult::INCORRECT_PASSWORD;

        }

    }

}

CustomerRegisterResult SqlService::RegisterCustomer(const QString &phone_number, const QString &password, const QString &name)
{

    if (CheckIfPhoneNumberExists(phone_number)) {

        return CustomerRegisterResult::PHONE_ALREADY_REGISTERED;

    } else {

        qDebug() << phone_number << " " << password << " " << name;
        QSqlQuery register_customer_query(sql_database);
        register_customer_query.prepare("INSERT INTO customers VALUES ((?), (?), (?))");
        register_customer_query.addBindValue(phone_number);
        register_customer_query.addBindValue(password);
        register_customer_query.addBindValue(name);

        if (register_customer_query.exec()) {

            return CustomerRegisterResult::SUCCESS;

        }

    }

}

EmployeeLoginResult SqlService::LoginEmployee(const QString &name, const QString &surname, const QString &position, const QString &password) {

    qDebug() << name << " " << surname << " " << position << " " << password;

    if (!CheckIfEmployeeExists(name, surname, position)) {

        return EmployeeLoginResult::NO_EMPLOYEE_IN_DATABASE;

    } else {

        QSqlQuery check_password_query(sql_database);
        check_password_query.prepare("SELECT password FROM employees WHERE name = (?) AND surname = (?) AND position = (?)");
        check_password_query.addBindValue(name);
        check_password_query.addBindValue(surname);
        check_password_query.addBindValue(position);
        check_password_query.exec();

        QString correct_password;

        while (check_password_query.next()) {

            correct_password = check_password_query.value(0).toString();
            qDebug() << correct_password << " correct password";
            qDebug() << password << " password";

        }

        // compare method returns 0, if two strings are equal!
        if (!correct_password.compare(password, Qt::CaseSensitive)) {

            return EmployeeLoginResult::SUCCESS;

        } else {

            return EmployeeLoginResult::INCORRECT_PASSWORD;

        }

    }

}

bool SqlService::CheckIfPhoneNumberExists(const QString &phone_number) {

    qDebug() << "Check exists phone " << phone_number;
    QSqlQuery check_phone_query(sql_database);
    check_phone_query.prepare("SELECT EXISTS (SELECT 1 FROM customers WHERE phone_number = (?))");
    check_phone_query.addBindValue(phone_number);
    check_phone_query.exec();

    if (check_phone_query.next()) {

        return check_phone_query.value(0).toBool();

    }

}

bool SqlService::CheckIfEmployeeExists(const QString &name, const QString &surname, const QString &position) {

    QSqlQuery login_query(sql_database);
    login_query.prepare("SELECT EXISTS (SELECT 1 FROM employees WHERE name = (?) AND surname = (?) AND position = (?))");
    login_query.addBindValue(name);
    login_query.addBindValue(surname);
    login_query.addBindValue(position);
    login_query.exec();

    if (login_query.next()) {

        bool result = login_query.value(0).toBool();
        qDebug() << "employee exists " << result;
        return result;

    }

}

QJsonArray SqlService::GetCatalogData() {

    QSqlQuery get_catalog_query(sql_database);

    qDebug() << "Get catalog query: " << get_catalog_query.exec("SELECT product_id, product_type, product_name, price, "
                                                                "scoville, description FROM catalog;");

    QJsonObject catalog_message;
    QJsonArray catalog_array;

    while (get_catalog_query.next()) {

        QJsonObject catalog_position;

        QString id(get_catalog_query.value(0).toString());
        QString type(get_catalog_query.value(1).toString());
        QString name(get_catalog_query.value(2).toString());
        QString price(get_catalog_query.value(3).toString());
        QString scoville(get_catalog_query.value(4).toString());
        QString description(get_catalog_query.value(5).toString());

        catalog_position[QStringLiteral("product_id")] = id;
        catalog_position[QStringLiteral("product_type")] = type;
        catalog_position[QStringLiteral("product_name")] = name;
        catalog_position[QStringLiteral("price")] = price;
        catalog_position[QStringLiteral("scoville")] = scoville;
        catalog_position.insert("description", QJsonValue::fromVariant(description.toUtf8()));

        catalog_array.push_back(catalog_position);

    }

    return catalog_array;

}

QJsonArray SqlService::GetCustomerActiveOrders(const QString &phone_number) {

    qDebug() << "Try get sql active orders";

    QJsonArray orders_array;

    QSqlQuery get_active_orders_query(sql_database);
    get_active_orders_query.prepare("SELECT order_id, ordered_timestamp, receive_code, order_data, total_cost, is_ready FROM active_orders "
                                    "WHERE phone_number = (?)");
    get_active_orders_query.addBindValue(phone_number);

    if (get_active_orders_query.exec()) {

        while (get_active_orders_query.next()) {

            QJsonObject order_json;

            order_json[QStringLiteral("order_id")] = get_active_orders_query.value(0).toInt();
            order_json[QStringLiteral("ordered_timestamp")] = get_active_orders_query.value(1).toString();
            order_json[QStringLiteral("receive_code")] = get_active_orders_query.value(2).toString();
            order_json[QStringLiteral("order_data")] = get_active_orders_query.value(3).toString();
            order_json[QStringLiteral("total_cost")] = get_active_orders_query.value(4).toInt();
            order_json[QStringLiteral("is_ready")] = get_active_orders_query.value(5).toBool();

            orders_array.push_back(order_json);

        }

    }

    return orders_array;

}

QJsonArray SqlService::GetCustomerReceivedOrders(const QString &phone_number) {

    qDebug() << "Try get sql received orders";

    QJsonArray orders_array;

    QSqlQuery get_received_orders_query(sql_database);
    get_received_orders_query.prepare("SELECT order_id, ordered_timestamp, receive_code, order_data, total_cost FROM received_orders "
                                    "WHERE phone_number = (?)");
    get_received_orders_query.addBindValue(phone_number);

    if (get_received_orders_query.exec()) {

        while (get_received_orders_query.next()) {

            QJsonObject order_json;

            order_json[QStringLiteral("order_id")] = get_received_orders_query.value(0).toInt();
            order_json[QStringLiteral("ordered_timestamp")] = get_received_orders_query.value(1).toString();
            order_json[QStringLiteral("receive_code")] = get_received_orders_query.value(2).toString();
            order_json[QStringLiteral("order_data")] = get_received_orders_query.value(3).toString();
            order_json[QStringLiteral("total_cost")] = get_received_orders_query.value(4).toInt();

            orders_array.push_back(order_json);

        }

    }

    return orders_array;

}

int SqlService::AddOrder(const QString& phone_number, const QString& timestamp, const int& total_cost, const QJsonArray& order_array, const QString& order_code) {

    QSqlQuery add_order_query(sql_database);
    add_order_query.prepare("INSERT INTO active_orders VALUES (DEFAULT, (?), (?), (?), (?), (?), (?))");
    add_order_query.addBindValue(phone_number);
    add_order_query.addBindValue(timestamp);
    add_order_query.addBindValue(order_code);
    add_order_query.addBindValue(total_cost);
    add_order_query.addBindValue(QString(QJsonDocument(order_array).toJson()));
    add_order_query.addBindValue(false);

    qDebug() << "Add order total cost " << total_cost;

    if (!add_order_query.exec()) {

        qDebug() << add_order_query.lastError().text();
        return 0;

    }

    QSqlQuery get_id_query(sql_database);
    get_id_query.prepare("SELECT order_id FROM active_orders WHERE phone_number = (?) ORDER BY ordered_timestamp DESC LIMIT 1");
    get_id_query.addBindValue(phone_number);
    get_id_query.exec();

    while (get_id_query.next()) {

        int order_id = get_id_query.value(0).toInt();
        return order_id;

    }

}

bool SqlService::CheckIfOrderIsCorrect(const QVector<int> &product_ids) {

    for (int i = 0; i < product_ids.size(); ++i) {

        QSqlQuery check_order_query(sql_database);
        check_order_query.prepare("SELECT EXISTS (SELECT 1 FROM catalog WHERE id = (?))");
        check_order_query.addBindValue(product_ids[i]);
        check_order_query.exec();

        if (check_order_query.next()) {

            if (!check_order_query.value(0).toBool()) {

                return false;

            }

        }

    }

    return true;

}

bool SqlService::CheckIfOrderExists(const int &order_id, const QString &phone_number, const QString &receive_code) {

    QSqlQuery check_order_query(sql_database);
    check_order_query.prepare("SELECT EXISTS (SELECT 1 FROM active_orders WHERE id = (?) AND phone_number = (?) AND receive_code = (?))");
    check_order_query.addBindValue(order_id);
    check_order_query.addBindValue(phone_number);
    check_order_query.addBindValue(receive_code);
    check_order_query.exec();

    while(check_order_query.next()) {

        return check_order_query.value(0).toBool();

    }

}

bool SqlService::CheckIfOrderExists(const int &order_id) {

    QSqlQuery check_order_query(sql_database);
    check_order_query.prepare("SELECT EXISTS (SELECT 1 FROM active_orders WHERE id = (?))");
    check_order_query.addBindValue(order_id);
    check_order_query.exec();

    while(check_order_query.next()) {

        return check_order_query.value(0).toBool();

    }
}


bool SqlService::CancelOrder(const int &order_id, const QString &phone_number, const QString &receive_code) {

    if (CheckIfOrderExists(order_id, phone_number, receive_code)) {

        QSqlQuery cancel_order_query(sql_database);
        cancel_order_query.prepare("DELETE FROM active_orders WHERE id = (?)");
        cancel_order_query.addBindValue(order_id);
        return cancel_order_query.exec();

    } else {

        return false;

    }

}

bool SqlService::ChangeCustomerName(const QString &phone_number, const QString &new_name) {

    QSqlQuery change_name_query(sql_database);
    change_name_query.prepare("UPDATE customers SET name = (?) WHERE phone_number = (?)");
    change_name_query.addBindValue(new_name);
    change_name_query.addBindValue(phone_number);
    return change_name_query.exec();

}

AddReceivedOrderResult SqlService::AddReceivedOrder(const int &order_id, const QString &phone_number, const QString &ordered_timestamp, const QString& received_timestamp, const QString &receive_code, const int& total_cost, const QMap<int, int> &order_data) {

    if (!CheckIfOrderExists(order_id, phone_number, receive_code)) {

        return AddReceivedOrderResult::NO_ORDER_IN_DATABASE;

    } else {

        QVector<int> product_ids;

        for (auto& id : order_data) {

            product_ids.push_back(id);

        }

        if (!CheckIfOrderIsCorrect(product_ids)) {

            return AddReceivedOrderResult::INCORRECT_PRODUCT_ID;

        } else {

            QSqlQuery add_received_order_query(sql_database);
            add_received_order_query.exec("INSERT INTO received_orders VALUES (order_id, phone_number, ordered_timestamp, receive_code, total_cost, order_data)"
                                          "SELECT order_id, phone_number, ordered_timestamp, receive_code, total_cost, order_data FROM active_orders");
            QSqlQuery add_received_timestamp_query;
            add_received_timestamp_query.prepare("INSERT INTO received_orders (received_timestamp) VALUES (?)");
            add_received_timestamp_query.addBindValue(received_timestamp);
            add_received_timestamp_query.exec();
            return AddReceivedOrderResult::SUCCESS;

        }

    }

}

void SqlService::CreateTablesIfNotExists() {

    qDebug() << "Create tables if not exit";

    // Create customers table if it doesn't exist
    QSqlQuery check_customers_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'customers')", sql_database);
    check_customers_table_query.exec();

    while (check_customers_table_query.next()) {

        if (!check_customers_table_query.value(0).toBool()) {

            qDebug() << "Create table";
            QSqlQuery customers_table_query("CREATE TABLE customers (phone_number VARCHAR(11), password TEXT, name VARCHAR(30))", sql_database);
            customers_table_query.exec();

        }

    }

    // Create employees table if it doesn't exist
    QSqlQuery check_employees_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'employees')", sql_database);
    check_employees_table_query.exec();

    while (check_employees_table_query.next()) {

        if (!check_employees_table_query.value(0).toBool()) {

            qDebug() << "Create table";
            QSqlQuery employees_table_query("CREATE TABLE employees (name VARCHAR(30), surname VARCHAR(30), "
                                            "position VARCHAR(20), password TEXT)", sql_database);
            employees_table_query.exec();

        }

    }


    // Create active orders table and set sequence start value if it doesn't exist
    QSqlQuery check_active_orders_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'active_orders')", sql_database);
    check_active_orders_table_query.exec();

    while (check_active_orders_table_query.next()) {

        if (!check_active_orders_table_query.value(0).toBool()) {

            qDebug() << "Create table";
            QSqlQuery active_orders_table_query("CREATE TABLE IF NOT EXISTS active_orders (order_id SERIAL, phone_number VARCHAR(11), "
                                         "ordered_timestamp TIMESTAMP, receive_code CHAR(4), order_data JSON)", sql_database);
            active_orders_table_query.exec();

            QSqlQuery set_order_id_query("ALTER SEQUENCE active_orders_order_id_seq RESTART WITH 100000", sql_database);
            set_order_id_query.exec();

        }

    }

    // Create received orders table and set sequence start value if it doesn't exist
    QSqlQuery check_received_orders_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'received_orders')", sql_database);
    check_received_orders_table_query.exec();

    while (check_received_orders_table_query.next()) {

        if (!check_received_orders_table_query.value(0).toBool()) {

            qDebug() << "Create table";
            QSqlQuery orders_table_query("CREATE TABLE IF NOT EXISTS received_orders (order_id INT, phone_number VARCHAR(11), "
                                         "ordered_timestamp TIMESTAMP, received_timestamp TIMESTAMP, receive_code CHAR(4), "
                                         "order_data JSON)", sql_database);
            orders_table_query.exec();

        }

    }

    // Create catalog table and set sequence start value if it doesn't exist
    QSqlQuery check_catalog_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'catalog')", sql_database);
    check_catalog_table_query.exec();

    while (check_catalog_table_query.next()) {

        if (!check_catalog_table_query.value(0).toBool()) {

            qDebug() << "Create table";

            QSqlQuery catalog_table_query("CREATE TABLE catalog (product_id INT, product_type TEXT, product_name TEXT, price INT, "
                                          "scoville INT, description JSON)", sql_database);
            catalog_table_query.exec();

        }

    }

}
