import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


ListModel {

    id: received_orders_model

    property int order_id;
    property string ordered_timestamp;
    property string received_timestamp;
    property string receive_code;
    property int total_cost;
    property var order_data; //json array object

}
