import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seeds_model

    property string name
    property string description
    property int cost
    property int items_left
    property Image image

    Component.onCompleted: {

        seeds_model.append( {name: "Pepper Seeds1", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds2", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds3", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds4", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds5", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds6", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds7", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
        seeds_model.append( {name: "Pepper Seeds8", description: "Seeds description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/data.jpeg" } );
    }
}
