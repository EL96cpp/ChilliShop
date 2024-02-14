import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ListModel {

    id: issuing_orders_list_model_copy    

    property int order_id;
    property string ordered_timestamp;
    property string receive_code;
    property string phone_number;
    property int total_cost;
    property var order_data; //json array object

    property string code_mask;
    property string phone_mask;

}
