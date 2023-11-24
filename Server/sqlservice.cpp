#include "sqlservice.h"

SqlService::SqlService(QObject *parent)
    : QObject{parent}, sql_database(QSqlDatabase::addDatabase("QPSQL"))
{

    sql_database.setHostName("127.0.0.1");
    sql_database.setPort(5432);
    sql_database.setDatabaseName("chilli_shop");
    sql_database.setUserName("postgres");
    sql_database.setPassword("postgres");
    bool database_opened = sql_database.open();

    if (database_opened) {

        qDebug() << "Databse opened!";
        CreateTablesIfNotExists();

    } else {

        qDebug() << "Postgres database connection error!";

    }


}

QByteArray SqlService::GetCatalogData()
{

    const QUrl url = QString::fromLatin1("../Catalog Images/Sauces/data.jpeg");

    QJsonObject json_object;

    QString test = url.path();
    QImage myImage(test);
    qDebug() << myImage.size();

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    myImage.save(&buffer, "JPEG");
    auto const encoded = buffer.data().toBase64();
    json_object[QStringLiteral("Image")] = QLatin1String(encoded);


    QByteArray ba;
    return ba;

}

void SqlService::CreateTablesIfNotExists()
{

    // Create customers table if it doesn't exist
    QSqlQuery check_customers_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'customers');");
    while (check_customers_table_query.next()) {

        if (!check_customers_table_query.value(0).toBool()) {

            QSqlQuery customers_table_query("CREATE TABLE customers (phone_number VARCHAR(11), password TEXT, name VARCHAR(30));");
            customers_table_query.exec();

        }

    }

    // Create employees table if it doesn't exist
    QSqlQuery check_employees_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'employees');");
    while (check_employees_table_query.next()) {

        if (!check_employees_table_query.value(0).toBool()) {

            QSqlQuery employees_table_query("CREATE TABLE employees (name VARCHAR(30), surname VARCHAR(30), "
                                            "position VARCHAR(20), password TEXT);");
            employees_table_query.exec();

        }

    }


    // Create orders table and set sequence start value if it doesn't exist
    QSqlQuery check_orders_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'orders');");
    while (check_orders_table_query.next()) {

        if (!check_orders_table_query.value(0).toBool()) {

            QSqlQuery orders_table_query("CREATE TABLE IF NOT EXISTS orders (order_id SERIAL, phone_number VARCHAR(11), "
                                         "receive_code VARCHAR(4), order_data JSON);");
            orders_table_query.exec();

            QSqlQuery set_order_id_query("ALTER SEQUENCE orders_order_id_seq RESTART WITH 100000;");
            set_order_id_query.exec();

        }

    }


    // Create catalog table and set sequence start value if it doesn't exist
    QSqlQuery check_catalog_table_query("SELECT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'catalog');");
    while (check_catalog_table_query.next()) {

        if (!check_catalog_table_query.value(0).toBool()) {

            QSqlQuery create_product_enum_query("CREATE TYPE PRODUCT_TYPE AS ENUM ('sauces', 'seasonings', 'seeds');");
            create_product_enum_query.exec();

            QSqlQuery catalog_table_query("CREATE TABLE catalog (product_id SERIAL, type PRODUCT_TYPE, product_name TEXT, price INT, "
                                          "scoville INT, description JSON);");
            catalog_table_query.exec();

            QSqlQuery set_product_id_query("ALTER SEQUENCE catalog_product_id_seq RESTART WITH 10000;");
            set_product_id_query.exec();


        }

    }


}
