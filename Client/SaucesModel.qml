import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: sauces_model

    property int id
    property string name
    property string text_description
    property double volume
    property var peppers
    property int price
    property int scoville
    property Image image


    function sortByPriceDecrease() {

        for (var i = 0; i < count; ++i) {

            var max_index = i;

            for (var j = i + 1; j < count; ++j) {

                if (get(j).price >= get(max_index).price) {

                    max_index = j;

                }

            }

            if (max_index != i) {

                move(max_index, i, 1);

            }

        }

    }

    function sortByPriceIncrease() {

        for (var i = 0; i < count; ++i) {

            var min_index = i;

            for (var j = i + 1; j < count; ++j) {

                if (get(j).price <= get(min_index).price) {

                    min_index = j;

                }

            }

            if (min_index != i) {

                move(min_index, i, 1);

            }


        }

    }

    function sortByScovilleDecrease() {

        for (var i = 0; i < count; ++i) {

            var max_index = i;

            for (var j = i + 1; j < count; ++j) {

                if (get(j).scoville >= get(max_index).scoville) {

                    max_index = j;

                }

            }

            if (max_index != i) {

                move(max_index, i, 1);

            }

        }

    }

    function sortByScovilleIncrease() {

        for (var i = 0; i < count; ++i) {

            var min_index = i;

            for (var j = i + 1; j < count; ++j) {

                if (get(j).scoville <= get(min_index).scoville) {

                    min_index = j;

                }

            }

            if (min_index != i) {

                move(min_index, i, 1);

            }


        }

    }

    /*
    Component.onCompleted: {

        sauces_model.append( {id: "10000", name: "Hot Sauce1", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Carolina Reaper", "Habanero"]},
                              price: 3, scoville: 20000, image: "file://" + applicationDirPath + "/../Images/Catalog/Sauces/" + id + ".png"} );
        sauces_model.append( {name: "Hot Sauce2", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Habanero"]},
                              price: 5, scoville: 200000, image: "qrc:/goods_images/large_CK-FIRMA.jpg"} );
        sauces_model.append( {name: "Hot Sauce3", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Jalapeno", "Scorpion Moruga"]},
                              price: 8, scoville: 120000, image: "qrc:/goods_images/large_CK-FIRMA.jpg"} );
        sauces_model.append( {name: "Hot Sauce4", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Ghost Pepper"]},
                              price: 2, scoville: 100000, image: "qrc:/goods_images/large_CK-FIRMA.jpg"} );
        sauces_model.append( {name: "Hot Sauce5", description: {"text":"Sauce description",
                                                                 "volume" : "0.5 л",
                                                                "peppers" : ["Scorpion Moruga"]},
                              price: 1, scoville: 1200000, image: "qrc:/goods_images/large_CK-FIRMA.jpg"} );

    }
    */

}

