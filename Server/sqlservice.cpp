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

    return get_name_query.value(0).toString();

}

CustomerLoginResult SqlService::LoginCustomer(const QString &phone_number, const QString &password) {

    if (!CheckIfPhoneNumberExists(phone_number)) {

        return CustomerLoginResult::NO_PHONE_IN_DATABASE;

    }

    QSqlQuery login_customer_query(sql_database);
    login_customer_query.prepare("SELECT password FROM cutomers WHERE phone_number = (?)");
    login_customer_query.addBindValue(phone_number);
    login_customer_query.exec();
    QString correct_password = login_customer_query.value(0).toString();

    // compare method returns 0, if two strings are equal!
    if (!correct_password.compare(password, Qt::CaseSensitive)) {

        return CustomerLoginResult::SUCCESS;

    } else {

        return CustomerLoginResult::INCORRECT_PASSWORD;

    }

}

CustomerRegisterResult SqlService::RegisterCustomer(const QString &phone_number, const QString &password, const QString &name)
{

    if (CheckIfPhoneNumberExists(phone_number)) {

        return CustomerRegisterResult::PHONE_ALREADY_REGISTERED;

    } else {

        return CustomerRegisterResult::SUCCESS;

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

QByteArray SqlService::GetCatalogData() {

    QSqlQuery get_catalog_query("SELECT product_id, product_type, product_name, price, "
                                "scoville, description FROM catalog", sql_database);
    get_catalog_query.exec();

    QJsonObject catalog_message;
    QJsonArray catalog_array;

    while (get_catalog_query.next()) {

        QJsonObject catalog_position;

        int id = get_catalog_query.value(0).toInt();
        QString type(get_catalog_query.value(1).toString());
        QString name(get_catalog_query.value(2).toString());
        int price = get_catalog_query.value(3).toInt();
        int scoville = get_catalog_query.value(4).toInt();
        QJsonObject description = get_catalog_query.value(5).toJsonObject();

        catalog_position[QStringLiteral("product_id")] = id;
        catalog_position[QStringLiteral("product_type")] = type;
        catalog_position[QStringLiteral("product_name")] = name;
        catalog_position[QStringLiteral("price")] = price;
        catalog_position[QStringLiteral("scoville")] = scoville;
        catalog_position[QStringLiteral("description")] = description;

        QUrl url;

        if (type.compare(QStringLiteral("Sauce")) == 0) {

            url = QString::fromLatin1("../Catalog Images/Sauces/") + QString::number(id) + QString::fromLatin1(".png");

        } else if (type.compare(QStringLiteral("Seasoning")) == 0) {

            url = QString::fromLatin1("../Catalog Images/Seasonings/") + QString::number(id) + QString::fromLatin1(".png");

        } else if (type.compare(QStringLiteral("Seeds")) == 0) {

            url = QString::fromLatin1("../Catalog Images/Seeds/") + QString::number(id) + QString::fromLatin1(".png");

        }

        QImage myImage(url.path());
        QBuffer buffer;
        buffer.open(QIODevice::WriteOnly);
        myImage.save(&buffer, "PNG");
        auto const encoded = buffer.data().toBase64();
        catalog_position[QStringLiteral("image")] = QLatin1String(encoded);

        catalog_array.push_back(catalog_position);

    }

    return QJsonDocument(catalog_array).toJson(QJsonDocument::Compact);

    /*
    const QUrl url = QString::fromLatin1("../Catalog Images/Sauces/data.jpeg");

    QJsonObject json_object;

    QString test = url.path();
    QImage myImage(test);

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    myImage.save(&buffer, "JPEG");
    auto const encoded = buffer.data().toBase64();
    json_object[QStringLiteral("Image")] = QLatin1String(encoded);

    QByteArray ba;
    return ba;
    */

}

bool SqlService::AddOrder(const QString& phone_number, const QString& timestamp, const QJsonArray& order_array, const QString& order_code) {

    QSqlQuery add_order_query(sql_database);
    add_order_query.prepare("INSERT INTO oders VALUES (DEFAULT, (?), (?), (?), (?))");
    add_order_query.addBindValue(phone_number);
    add_order_query.addBindValue(timestamp);
    add_order_query.addBindValue(order_code);
    add_order_query.addBindValue(order_array);

    return add_order_query.exec();

}

bool SqlService::CheckIfOrderIsCorrect(const QVector<QString> &product_ids) {

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

bool SqlService::CheckIfOrderExists(const QString& phone_number, const int& order_id) {

    QSqlQuery check_order_query(sql_database);
    check_order_query.prepare("SELECT EXISTS (SELECT 1 FROM orders WHERE id = (?) AND phone_number = (?))");
    check_order_query.addBindValue(order_id);
    check_order_query.addBindValue(phone_number);
    check_order_query.exec();

    while(check_order_query.next()) {

        return check_order_query.value(0).toBool();

    }

}

bool SqlService::CancelOrder(const QString &phone_number, const int &order_id) {

    if (CheckIfOrderExists(phone_number, order_id)) {

        QSqlQuery cancel_order_query(sql_database);
        cancel_order_query.prepare("DELETE FROM orders WHERE id = (?)");
        cancel_order_query.addBindValue(order_id);
        cancel_order_query.exec();
        return true;

    } else {

        return false;

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
            QSqlQuery create_product_enum_query("CREATE TYPE PRODUCT_TYPE AS ENUM ('sauces', 'seasonings', 'seeds')", sql_database);
            create_product_enum_query.exec();

            QSqlQuery catalog_table_query("CREATE TABLE catalog (product_id INT, product_type PRODUCT_TYPE, product_name TEXT, price INT, "
                                          "scoville INT, description JSON)", sql_database);
            catalog_table_query.exec();

        }

    }

}
