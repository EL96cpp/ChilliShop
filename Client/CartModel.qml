import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: cart_model
    property string name
    property var description_json
    property var peppers_json
    property int cost
    property int scoville
    property int number_of_items
    property Image image

}
