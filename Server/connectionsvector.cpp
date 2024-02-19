#include "connectionsvector.h"

ConnectionsVector::ConnectionsVector(QObject* parent) : QObject{parent} {}

void ConnectionsVector::push(ClientConnection *client_connection) {

    QMutexLocker locker(&mutex);
    connections.push_back(client_connection);
    qDebug() << "new connection added to vector " << connections.size();

}

void ConnectionsVector::erase(ClientConnection *client_connection) {

    QMutexLocker locker(&mutex);
    connections.erase(std::remove(connections.begin(), connections.end(), client_connection), connections.end());

}

void ConnectionsVector::eraseByPhoneNumber(const QString &phone_number) {

    QMutexLocker locker(&mutex);

    connections.erase(std::remove_if(connections.begin(), connections.end(),
                                     [&phone_number](ClientConnection* connection){
                                        return connection->GetPhoneNumber() == phone_number;
                                        }), connections.end());

}

void ConnectionsVector::eraseByEmployeeData(const EmployeeData &employee_data) {

    QMutexLocker locker(&mutex);

    qDebug() << "Remove employee connection " << connections.size();
    connections.erase(std::remove_if(connections.begin(), connections.end(),
                                     [&employee_data](ClientConnection* connection){
                                         return connection->GetEmployeeData() == employee_data;
                                     }), connections.end());
    qDebug() << "Remove employee connection " << connections.size();
}

bool ConnectionsVector::CheckIfCustomerAlreadyLogged(const QString &phone_number) {

    QMutexLocker locker(&mutex);

    for (int i = 0; i < connections.size(); ++i) {

        if (connections[i]->GetConnectionType() == ConnectionType::CUSTOMER) {

            if (connections[i]->GetPhoneNumber() == phone_number) {

                return true;

            } else {

                continue;

            }

        } else {

            continue;

        }

    }

    return false;

}

bool ConnectionsVector::CheckIfEmployeeAlreadyLogged(const QString &name, const QString &surname, const QString &position) {

    QMutexLocker locker(&mutex);

    for (int i = 0; i < connections.size(); ++i) {

        if (connections[i]->GetConnectionType() == ConnectionType::EMPLOYEE) {

            if (connections[i]->CheckIfEmployeeDataIsEqual(EmployeeData(name, surname, position))) {

                return true;

            } else {

                continue;

            }

        } else {

            continue;

        }

    }

    return false;


}

void ConnectionsVector::onSendToAllEmployees(const QByteArray &message_byte_array) {

    QMutexLocker locker(&mutex);

    for (int i = 0; i < connections.size(); ++i) {

        if (connections[i]->GetConnectionType() == ConnectionType::EMPLOYEE) {

            connections[i]->SendMessage(message_byte_array);

        }

    }

}

void ConnectionsVector::onSendToAllEmployeesExceptOne(const EmployeeData& employee_data, const QByteArray &message_byte_array) {

    QMutexLocker locker(&mutex);

    for (int i = 0; i < connections.size(); ++i) {

        if (connections[i]->GetConnectionType() == ConnectionType::EMPLOYEE && connections[i]->GetEmployeeData() != employee_data) {

            connections[i]->SendMessage(message_byte_array);

        }

    }

}

void ConnectionsVector::onSendToCustomer(const QString &phone_number, const QByteArray &message_byte_array) {

    QMutexLocker locker(&mutex);

    for (int i = 0; i < connections.size(); ++i) {

        if (connections[i]->GetPhoneNumber() == phone_number) {

            connections[i]->SendMessage(message_byte_array);
            break;

        }

    }

}

