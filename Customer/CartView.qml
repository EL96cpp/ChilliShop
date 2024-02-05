import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Rectangle {

    id: cart_rectangle
    width: (main_window.width - grid_rectangle.width - anchors.margins*4) / 2
    height: 630
    color: main_window.forms_background_color
    border.width: 2
    border.color: main_window.forms_border_color
    radius: 15

    anchors.top: header_rect.bottom
    anchors.right: parent.right
    anchors.margins: 20

    property bool is_empty: cart_model.count === 0

    signal setOrderConfirmState();

    Rectangle {

        id: cart_title_rect
        width: cart_title.paintedWidth * 3
        height: cart_title.paintedHeight

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.25; color: "#809a2901" }
            GradientStop { position: 0.75; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        anchors.horizontalCenter: cart_rectangle.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25

        Text {

            id: cart_title
            text: "Корзина"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: true
            anchors.centerIn: parent

        }

    }

    Canvas {

        id: cart_line
        width: cart_title.paintedWidth * 3
        height: 20
        anchors.horizontalCenter: cart_rectangle.horizontalCenter
        anchors.top: cart_title_rect.bottom
        anchors.topMargin: 5

        onPaint: {

            var ctx = getContext("2d")

            ctx.strokeStyle = main_window.forms_line_color
            ctx.lineWidth = 8

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Rectangle {

        id: cart_list_rectangle
        width: parent.width
        height: 420
        anchors.top: cart_line.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: cart_line.horizontalCenter
        color: "#80481300"
        clip: true

        ListView {

            id: cart_view
            model: cart_model
            anchors.fill: parent
            spacing: 10
            clip: true

            onCountChanged: {

                cart_view.currentIndex = count - 1;

            }

            delegate: Rectangle {

                id: cart_item_delegate
                width: cart_rectangle.width-20
                height: 80
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90713103"
                border.width: 1
                border.color: "#7a4620"

                Connections {

                    target: custom_spinbox

                    function onChangeItemCounterSignal(value) {

                        cart_model.changeNumberOfItems(model.name, value);
                        cart_total_cost_data.text = cart_model.total_price/100 + "." +
                                                    ((cart_model.total_price%100 < 10) ?
                                                    cart_model.total_price%100 + "0" : cart_model.total_price%100) + " ₽";

                    }

                }


                Image {

                    id: cart_item_image
                    sourceSize.height: 40
                    source: model.image

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 30

                }

                CustomSpinbox {

                    id: custom_spinbox
                    height: 20
                    width: 70
                    spinbox_value: model.number_of_items
                    anchors.top: cart_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: cart_item_image.horizontalCenter

                    Connections {

                        target: cart_model

                        function onSetItemCounter(product_name, number_of_items) {

                            if (model.name === product_name) {

                                custom_spinbox.spinbox_value = number_of_items;

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
                            cart_total_cost_data.text = cart_model.calculateTotalPrice() + " ₽";

                        }

                    }

                }

                Text {

                    id: cart_item_total_cost
                    text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽";
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

    Button {

        id: order_button
        width: 150
        height: 40

        anchors.top: cart_list_rectangle.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle {

            color: order_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            border.width: 2
            border.color: "#692b06"
            radius: 20

        }

        hoverEnabled: true

        contentItem: Text {

            text: "Оформить"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: order_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            if (cart_model.count !== 0) {

                profile_page.setOrderConfirmState();
                stack_view.push(profile_page);

            }
        }

    }

    Row {

        id: cart_total_row
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        Text {

            id: cart_total_cost_title
            text: "Сумма заказа: "
            color: "white"
            font.family: regular_font.name
            font.pointSize: 14
            font.wordSpacing: 5
            font.bold: true

        }

        Text {

            id: cart_total_cost_data
            text: cart_model.total_price/100 + "." +
                  ((cart_model.total_price%100 < 10) ?
                  cart_model.total_price%100 + "0" : cart_model.total_price%100) + " ₽";
            color: "white"
            font.family: regular_font.name
            font.pointSize: 14
            font.wordSpacing: 5
            font.bold: true

        }

    }

    Connections {

        target: cart_model

        function onTotalPriceChanged() {

            cart_total_cost_data.text = cart_model.total_price/100 + "." +
                                        ((cart_model.total_price%100 < 10) ?
                                        cart_model.total_price%100 + "0" : cart_model.total_price%100) + " ₽";

        }

    }

    Connections {

        target: grid_rectangle

        function onAddToCartSignal(id, name, text_description, price, image) {

            cart_model.addToCart(id, name, text_description, price, image);
            
        }

    }

    Connections {

        target: clear_cart_text

        function onClearCartModel() {

            cart_model.clearCart();

        }

    }

}

