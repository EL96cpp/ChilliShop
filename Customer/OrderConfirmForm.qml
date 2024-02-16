import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Item {

    id: order_confirm_form

    property int total_price

    // add values for order data
    signal makeOrder(var order_array, var total_cost);

    Connections {

        target: cart_model

        function onTotalPriceChanged() {

            total_price = cart_model.total_price;

        }

    }

    Rectangle {

        id: order_confirm_rectangle
        width: 700
        height: 550
        color: "#804c1200"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        ListView {

            id: order_confirm_view
            model: cart_model
            width: order_confirm_rectangle.width - 10
            height: 530
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: cart_item_delegate
                width: order_confirm_rectangle.width-20
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90A84700"
                border.width: 1
                border.color: "#ecbc99"

                Connections {

                    target: custom_spinbox_profile

                    function onChangeItemCounterSignal(value) {

                        cart_model.changeNumberOfItems(model.name, value);

                    }

                }

                Image {

                    id: cart_item_image
                    sourceSize.height: 70
                    source: model.image

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 30

                }

                CustomSpinbox {

                    id: custom_spinbox_profile
                    height: 20
                    width: 70
                    anchors.top: cart_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: cart_item_image.horizontalCenter
                    spinbox_value: model.number_of_items

                    Connections {

                        target: cart_model

                        function onSetItemCounter(product_name, number_of_items) {

                            if (model.name === product_name) {

                                custom_spinbox_profile.spinbox_value = number_of_items;

                            }

                        }

                    }

                }

                Rectangle {

                    id: cart_item_name_rectangle
                    width: cart_item_name.paintedWidth * 1.5
                    height: cart_item_name.paintedHeight
                    anchors.left: cart_item_image.right
                    anchors.leftMargin: 15
                    anchors.top: cart_item_image.top

                    gradient: Gradient {

                        GradientStop { position: 0.0; color: "#303F1100" }
                        GradientStop { position: 0.05; color: "#903F1100" }
                        GradientStop { position: 0.5; color: "#ff3F1100" }
                        GradientStop { position: 0.95; color: "#903F1100" }
                        GradientStop { position: 1.0; color: "#303F1100" }
                        orientation: Gradient.Horizontal

                    }

                    Text {

                        id: cart_item_name
                        text: model.name
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true
                        anchors.centerIn: parent

                    }

                    Text {

                        id: cart_item_description
                        text: model.description
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true
                        anchors.left: cart_item_name.left
                        anchors.top: cart_item_name.bottom
                        anchors.topMargin: 10

                    }

                }

                Canvas {

                    id: delete_symbol
                    width: 10
                    height: 10
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 15

                    onPaint: {

                        var ctx = getContext("2d")

                        ctx.strokeStyle = "#E4E4E4"
                        ctx.lineWidth = 3

                        ctx.beginPath()

                        ctx.moveTo(0, 0)
                        ctx.lineTo(width, height)

                        ctx.moveTo(0, height)
                        ctx.lineTo(width, 0)

                        ctx.stroke()

                    }

                    MouseArea {

                        id: delete_item_mouse_area
                        anchors.fill: parent

                        onClicked: {

                            cart_model.removeFromCart(model.name);

                        }

                    }

                }

                Text {

                    id: cart_item_total_cost
                    text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽"
                    color: "white"
                    font.family: regular_font.name
                    font.pointSize: 15
                    font.wordSpacing: 5
                    font.bold: true

                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 10

                }

            }

        }

    }

    Rectangle {

        id: order_total_rectangle
        width: order_total_title.width*1.2
        height: order_total_title.height*1.2
        color: "#d0290A00"

        anchors.left: order_confirm_rectangle.left
        anchors.top: order_confirm_rectangle.bottom
        anchors.topMargin: 20

        Text {

            id: order_total_title
            text: "Итого: "
            color: "white"
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 5
            font.bold: true

            anchors.centerIn: parent

        }
    }

    Text {

        id: order_total_value
        text: total_price/100 + "." + ((total_price%100 < 10) ? total_price%100 + "0" : total_price%100) + " ₽"
        color: "white"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5

        anchors.top: order_total_rectangle.top
        anchors.left: order_total_rectangle.right
        anchors.leftMargin: 10

    }

    Button {

        id: confirm_order_button
        width: 210
        height: 50

        anchors.right: order_confirm_rectangle.right
        anchors.verticalCenter: order_total_rectangle.verticalCenter
        anchors.margins: 20

        background: Rectangle {

            color: confirm_order_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: confirm_order_button.hovered
            layer.effect: MultiEffect {

                id: confirm_order_button_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

        }

        hoverEnabled: true

        contentItem: Text {

            text: "Заказать"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 15
            font.letterSpacing: 5
            font.bold: true
            color: confirm_order_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            var order_json = cart_model.getOrderJson();
            Client.onMakeOrder(order_json, cart_model.total_price);

        }

    }

    Text {

        id: cancel_order_text
        text: "Очистить корзину"
        color: cancel_order_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        font.bold: true

        anchors.top: order_confirm_rectangle.top
        anchors.left: order_confirm_rectangle.right
        anchors.leftMargin: 120

        MouseArea {

            id: cancel_order_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                cart_model.clearCart();

            }

        }

    }

}
