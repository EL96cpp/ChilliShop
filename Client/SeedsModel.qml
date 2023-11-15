import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: seeds_model

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

        seeds_model.append( {name: "Pepper Seeds1", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Carolina Reaper"]},
                             price: 328, scoville: 2500000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds2", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Scorpion Moruga"]},
                             price: 24, scoville: 2200000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds3", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Carolina Reaper"]},
                             price: 18, scoville: 2500000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds4", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Scorpion Moruga"]},
                             price: 94, scoville: 2200000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds5", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Carolina Reaper"]},
                             price: 68, scoville: 2500000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds6", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Scorpion Moruga"]},
                             price: 25, scoville: 2200000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds7", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Carolina Reaper"]},
                             price: 28, scoville: 2500000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

        seeds_model.append( {name: "Pepper Seeds8", description: {"text" : "Seeds description",
                                                                  "number of seeds" : "10",
                                                                  "peppers" : ["Scorpion Moruga"]},
                             price: 124, scoville: 2200000, items_left: 10, image: "qrc:/goods_images/data.jpeg",
                             visible: true} );

    }
}
