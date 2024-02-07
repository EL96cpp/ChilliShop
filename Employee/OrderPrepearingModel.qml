import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListModel {

    id: order_prepearing_model

    property int order_id;
    property string ordered_timestamp;
    property int total_cost;
    property var order_data; //json array object

}
