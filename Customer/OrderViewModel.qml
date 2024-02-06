import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


ListModel {

    id: order_view_model

    property int product_id
    property string name
    property string description
    property int price
    property int number_of_items
    property string image

    property int order_id;
    property string receive_code
    property string ordered_timestamp
    property string received_timestamp
    property int total_cost
    property bool is_ready

}
