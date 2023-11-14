import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seeds_model

    property string name
    property var json_description
    property int cost
    property int items_left
    property Image image
    property bool visible

    Component.onCompleted: {

        seeds_model.append( {name: "Pepper Seeds1", description: {"text" : "Seeds description",
                                                                  "Number_of_seeds" : "10"},
                             cost: 158000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

    }
}
