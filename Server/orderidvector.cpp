#include "orderidvector.h"

OrderIDVector::OrderIDVector() {

}

bool OrderIDVector::push(const EmployeeData& employee_data, const int& id) {

    QMutexLocker lock(&mutex);

    for (int i = 0; i < ids_vector.size(); ++i) {

        if (ids_vector[i].second == id) {

            return false;

        }

    }

    ids_vector.push_back(std::make_pair(employee_data, id));
    qDebug() << "pushed id " << id;
    return true;

}

bool OrderIDVector::erase(const EmployeeData& employee_data, const int& id) {

    QMutexLocker lock(&mutex);
    std::pair<EmployeeData, int> pair = std::make_pair(employee_data, id);

    if (ids_vector.contains(pair)) {

        ids_vector.erase(std::remove(ids_vector.begin(), ids_vector.end(), pair), ids_vector.end());
        qDebug() << "removed id " << id;
        return true;

    } else {

        return false;

    }

}


void OrderIDVector::removeAllEmployeeIDs(const EmployeeData &employee_data) {

    QMutexLocker lock(&mutex);

    ids_vector.erase(std::remove_if(ids_vector.begin(), ids_vector.end(),
                     [&employee_data](const std::pair<EmployeeData, int>& pair) { return pair.first == employee_data; }),
                     ids_vector.end());

}

QJsonArray OrderIDVector::getAllOrderIDs() {

    QMutexLocker lock(&mutex);

    QJsonArray ids_json_array;

    for (int i = 0; i < ids_vector.size(); ++i) {

        ids_json_array.push_back(QJsonValue(ids_vector[i].second));

    }

    return ids_json_array;

}
