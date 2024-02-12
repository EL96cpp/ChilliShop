import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListModel {

    id: prepearing_order_model

    property int product_id
    property string name
    property string description
    property int price
    property int number_of_items
    property string image
    property bool prepeared

    property int order_id;
    property string ordered_timestamp
    property string phone_number
    property int total_cost

}
