
import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seasonings_model

    property string name
    property var json_description
    property int price
    property int items_left
    property Image image
    property bool visible

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

    Component.onCompleted: {

        seasonings_model.append( {name: "Seasoning1", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "150",
                                                                    "peppers" : ["Carolina Reaper", "Habanero"]},
                                  price: 11, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning2", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "250",
                                                                    "peppers" : ["Ghost Pepper"]},
                                  price: 1, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning3", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "150",
                                                                    "peppers" : ["Carolina Reaper", "Habanero"]},
                                  price: 5, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning4", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "250",
                                                                    "peppers" : ["Ghost Pepper"]},
                                  price: 6, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning5", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "150",
                                                                    "peppers" : ["Carolina Reaper", "Habanero"]},
                                  price: 71, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning6", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "250",
                                                                    "peppers" : ["Ghost Pepper"]},
                                  price: 5, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning7", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "150",
                                                                    "peppers" : ["Carolina Reaper", "Habanero"]},
                                  price: 12, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

        seasonings_model.append( {name: "Seasoning8", description: {"text" : "Seasoning description",
                                                                    "weight_grams" : "250",
                                                                    "peppers" : ["Ghost Pepper"]},
                                  price: 5, items_left: 10, image: "qrc:/goods_images/carolina_reaper_powder.jpg",
                                  visible: true} );

    }
}
