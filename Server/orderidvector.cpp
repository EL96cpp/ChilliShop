#include "orderidvector.h"

OrderIDVector::OrderIDVector() {

}

bool OrderIDVector::push(const int &id) {

    QMutexLocker lock(&mutex);

    if (ids_vector.contains(id)) {

        return false;

    } else {

        ids_vector.push_back(id);
        return true;

    }

}

bool OrderIDVector::erase(const int &id) {

    QMutexLocker lock(&mutex);

    if (ids_vector.contains(id)) {

        ids_vector.erase(std::remove(ids_vector.begin(), ids_vector.end(), id), ids_vector.end());
        return true;

    } else {

        return false;

    }

}

void OrderIDVector::removeAllEmployeeIDs(const EmployeeData &employee_data) {

    //Remove all id's, added by employee (In case employee got disconnected)

}
