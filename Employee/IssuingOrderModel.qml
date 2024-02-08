import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListModel {

    id: issuing_order_model

    property int product_id
    property string name
    property string description
    property int price
    property int number_of_items
    property string image

    property int order_id;
    property string phone_number
    property string receive_code
    property string ordered_timestamp
    property int total_cost

}
