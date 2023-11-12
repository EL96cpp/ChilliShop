import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: sauces_model

    property string name
    property string description
    property int cost
    property int items_left
    property Image image

    Component.onCompleted: {

        sauces_model.append( {name: "Hot Sauce1", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce2", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce3", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce4", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce5", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce6", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce7", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce8", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce9", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce10", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce11", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce12", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );


        sauces_model.append( {name: "Hot Sauce1", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce2", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce3", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce4", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce5", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce6", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce7", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce8", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce9", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce10", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce11", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );
        sauces_model.append( {name: "Hot Sauce12", description: "Sauce description", cost: 158000,
                                items_left: 10, image: "qrc:/goods_images/large_CK-FIRMA.jpg" } );

    }


}
