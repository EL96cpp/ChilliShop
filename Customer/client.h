#ifndef CLIENT_H
#define CLIENT_H

#include <QSslSocket>
#include <QObject>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument>
#include <QJsonArray>
#include <QByteArray>
#include <QDateTime>

class Client : public QObject
{
    Q_OBJECT
public:
    Client();
    void ConnectToServer(const QString& address, const quint16& port);


signals:
    void addSauceProductToModel(const int& id, const QString& name, const QString& type, const int& price, const int& scoville,
                                const QString& text_description, const double& volume, const QJsonArray& peppers);
    void addSeasoningProductToModel(const int& id, const QString& name, const QString& type, const int& price, const int& scoville,
                                    const QString& text_description, const int& weight, const QJsonArray& peppers);
    void addSeedsProductToModel(const int& id, const QString& name, const QString& type, const int& price, const int& scoville,
                                const QString& text_description, const int& number_of_seeds, const QJsonArray& peppers);
    void disconnected(const QString& error_description);
    void registerSuccess();
    void showMessage(const QString& message_title, const QString& message_description);
    void loginSuccess(const QString& phone_number, const QString& name);
    void changeNameSuccess(const QString& new_name);

    void addActiveOrder(const size_t& order_id, const QString& ordered_timestamp, const QString& receive_code,
                        const size_t& total_cost, const QJsonArray& order_data, const bool& is_ready);
    void addReceivedOrder(const size_t& order_id, const QString& ordered_timestamp, const QString& received_timestamp,
                          const QString& receive_code, const size_t& total_cost, const QJsonArray& order_data);
    void orderAccepted();
    void setOrderPrepeared(const int& order_id);

public slots:
    void onLogin(const QString& phone_number, const QString& password);
    void onRegister(const QString& phone_number, const QString& password, const QString& name);
    void onMakeOrder(const QJsonArray& order_data, const size_t& total_cost);
    void onCancelOrder(const int &order_id, const QString& phone_number, const QString &receive_code);
    void onReadyRead();
    void onChangeName(const QString& new_name);
    void onDisconnected();

private:
    void SendConnectionType();
    void GetCatalog();
    void GetActiveOrders();
    void GetReceivedOrders();
    void AddCatalogDataToModels(const QJsonArray& catalog_json_array);

private:
    QSslSocket* socket;
    QString phone_number;
    QString name;

};

#endif // CLIENT_H
