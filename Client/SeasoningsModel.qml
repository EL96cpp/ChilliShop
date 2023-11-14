import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seasonings_model

    property string name
    property var json_description
    property int cost
    property int items_left
    property Image image
    property bool visible

    Component.onCompleted: {

        seasonings_model.append( {name: "Seasoning1", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "150"}, cost: 198000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                visible: true} );


    }
}
