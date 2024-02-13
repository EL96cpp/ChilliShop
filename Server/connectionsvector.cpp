#include "connectionsvector.h"

ConnectionsVector::ConnectionsVector() {



}

void ConnectionsVector::push(ClientConnection *client_connection) {

    QMutexLocker locker(&mutex);
    connections.push_back(client_connection);
    qDebug() << "new connection added to vector " << connections.size();

}

void ConnectionsVector::erase(ClientConnection *client_connection) {

    QMutexLocker locker(&mutex);
    connections.erase(std::remove(connections.begin(), connections.end(), client_connection), connections.end());

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

