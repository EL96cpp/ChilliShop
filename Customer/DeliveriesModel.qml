import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


ListModel {

    id: active_orders_model

    property int order_id;
    property string ordered_timestamp;
    property string receive_code;
    property int total_cost;
    property var order_data; //json array object
    property bool is_ready;

    function setOrderPrepeared(order_id) {

        for (var i = 0; i < count; ++i) {

            if (get(i).order_id === order_id) {

                get(i).is_ready = true;
                break;

            }

        }

    }

}
