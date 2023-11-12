import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seasonings_model

    property string name
    property string description
    property int cost
    property int items_left
    property Image image

    Component.onCompleted: {

        seasonings_model.append( {name: "Seasoning1", description: "Seasoning description", cost: 198000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning2", description: "Seasoning description", cost: 178000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning3", description: "Seasoning description", cost: 18000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning4", description: "Seasoning description", cost: 148000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning5", description: "Seasoning description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning6", description: "Seasoning description", cost: 108000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning7", description: "Seasoning description", cost: 178000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning8", description: "Seasoning description", cost: 178000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );
        seasonings_model.append( {name: "Seasoning9", description: "Seasoning description", cost: 179000,
                                items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg" } );

    }
}
