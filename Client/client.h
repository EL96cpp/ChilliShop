#ifndef CLIENT_H
#define CLIENT_H

#include <QSslSocket>
#include <QObject>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument>
#include <QJsonArray>
#include <QByteArray>

class Client : public QObject
{
    Q_OBJECT
public:
    Client();
    void ConnectToServer(const QString& address, const quint16& port);


signals:
    void addSauceProductToModel(const int& id, const QString& name, const int& price, const int& scoville,
                                const QString& text_description, const double& volume, const QJsonArray& peppers);
    void addSeasoningProductToModel(const int& id, const QString& name, const int& price, const int& scoville,
                                    const QString& text_description, const int& weight, const QJsonArray& peppers);
    void addSeedsProductToModel(const int& id, const QString& name, const int& price, const int& scoville,
                                const QString& text_description, const int& number_of_seeds, const QJsonArray& peppers);
    void registerSuccess();
    void registerError(const QString& error_description);
    void loginSuccess(const QString& phone_number, const QString& name);
    void loginError(const QString& error_description);


public slots:
    void onLogin(const QString& phone_number, const QString& password);
    void onRegister(const QString& phone_number, const QString& password, const QString& name);
    void onMakeOrder(const QString& phone_number, const QString& order_datetime, const QJsonObject& order_data);
    void onReadyRead();
    void onChangeName(const QString& new_name);

private:
    void SendConnectionType();
    void GetCatalog();
    void GetOrdersHistory();
    void AddCatalogDataToModels(const QJsonArray& catalog_json_array);

private:
    QSslSocket* socket;
    QString phone_number;
    QString name;

};

#endif // CLIENT_H
