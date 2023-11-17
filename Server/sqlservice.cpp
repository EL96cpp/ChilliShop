#include "sqlservice.h"

SqlService::SqlService(QObject *parent)
    : QObject{parent}, sql_database(QSqlDatabase::addDatabase("QPSQL"))
{

    sql_database.setHostName("127.0.0.1");
    sql_database.setPort(5432);
    sql_database.setDatabaseName("chilli_shop");
    sql_database.setUserName("postgres");
    sql_database.setPassword("postgres");
    bool started = sql_database.open();
    qDebug() << "Postgres database started:" << started;

}
