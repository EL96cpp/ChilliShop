import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

ListModel {

    id: cart_model

    property string name
    property var description
    property int price
    property int scoville
    property int number_of_items
    property Image image

    function changeNumberOfItems(item_name, value) {

        for (var i = 0; i < count; ++i) {

            if (get(i).name === item_name) {

                get(i).number_of_items += value;

                if (get(i).number_of_items === 0) {

                    remove(i, 1);

                }

            }

        }

    }

    function addToCart(name, json_description, price, image) {

        var item_already_in_cart = false;

        for (var i = 0; i < count; ++i) {

            if (get(i).name === name) {

                item_already_in_cart = true;
                break;

            }

        }

        if (!item_already_in_cart) {

            append( {name: name, description: json_description, price: price, number_of_items: 1, image: image} );

        }

    }

    function removeFromCart(name) {

        for (var i = 0; i < count; ++i) {

            if (get(i).name === name) {

                remove(i, 1);

            }

        }

    }

    function getTotalOrderCost() {

        var total = 0;

        for (var i = 0; i < count; ++i) {

            total += get(i).price * get(i).number_of_items;

        }

        return total;

    }



}

