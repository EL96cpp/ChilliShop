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
    property double price
    property int scoville
    property Image image


    //Debug stuff
    function showPeppers() {

        for (var i = 0; i < count; ++i) {

            console.log(get(i).name);

            for (var j = 0; j < get(i).peppers.array.length; ++j) {

                console.log(get(i).peppers.array[j]);

            }

        }

    }


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

}

