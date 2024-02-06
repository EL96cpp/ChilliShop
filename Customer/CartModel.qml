import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


ListModel {

    id: cart_model

    property int id
    property string name
    property string description
    property int price
    property int scoville
    property int number_of_items
    property string image

    property int total_price

    signal totalPriceChanged();
    signal updateNumberOfItems();
    signal setItemCounter(var product_name, var number_of_items);

    function debugOutput() {

        for (var i = 0; i < count; ++i) {

            console.log(get(i).number_of_items + " " + get(i).name);

        }

        console.log("===================================");

    }
    
    function getOrderJson() {

        var order_json = [];

        for (var i = 0; i < count; ++i) {

            var order_position = {};
            order_position["id"] = get(i).id;
            order_position["name"] = get(i).name;
            order_position["description"] = get(i).description;
            order_position["price"] = get(i).price;
            order_position["number_of_items"] = get(i).number_of_items;

            order_json.push(order_position);

        }

        return order_json;

    }

    function updateTotalPrice() {

        total_price = 0;

        for (var i = 0; i < count; ++i) {

            total_price += get(i).price * get(i).number_of_items;

        }

        totalPriceChanged();
        debugOutput();

    }

    function changeNumberOfItems(item_name, value) {

        for (var i = 0; i < count; ++i) {

            if (get(i).name === item_name) {

                get(i).number_of_items += value;
                setItemCounter(item_name, get(i).number_of_items);

                if (get(i).number_of_items === 0) {

                    remove(i, 1);

                }

                break;

            }

        }

        updateTotalPrice();

    }

    function addToCart(id, name, text_description, price, image) {

        var item_already_in_cart = false;

        for (var i = 0; i < count; ++i) {

            if (get(i).id === id) {

                item_already_in_cart = true;
                break;

            }

        }

        if (!item_already_in_cart) {

            append( {id: id, name: name, description: text_description, price: price, number_of_items: 1, image: image} );
            updateTotalPrice();

        }

    }

    function removeFromCart(name) {

        for (var i = 0; i < count; ++i) {

            if (get(i).name === name) {

                remove(i, 1);
                break;

            }

        }

        updateTotalPrice();

    }

    function clearCart() {

        cart_model.clear();

        updateTotalPrice();

    }


}

