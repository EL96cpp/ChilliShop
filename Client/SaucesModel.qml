import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: sauces_model

    property string name
    property var json_description
    property int cost
    property int items_left
    property Image image
    property bool visible

    Component.onCompleted: {

        sauces_model.append( {name: "Hot Sauce1", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              cost: 158000, image: "qrc:/goods_images/large_CK-FIRMA.jpg", visible: true} );
        sauces_model.append( {name: "Hot Sauce2", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              cost: 158000, image: "qrc:/goods_images/large_CK-FIRMA.jpg", visible: true} );
        sauces_model.append( {name: "Hot Sauce3", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              cost: 158000, image: "qrc:/goods_images/large_CK-FIRMA.jpg", visible: true} );
        sauces_model.append( {name: "Hot Sauce4", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              cost: 158000, image: "qrc:/goods_images/large_CK-FIRMA.jpg", visible: true} );
        sauces_model.append( {name: "Hot Sauce5", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              cost: 158000, image: "qrc:/goods_images/large_CK-FIRMA.jpg", visible: true} );

    }


}
