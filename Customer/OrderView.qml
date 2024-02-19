import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Item {

    id: order_view

    property int total_cost
    property bool is_active

    signal showOrderCancelForm();

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.topMargin: 50
    anchors.leftMargin: 70

    Text {

        id: deliverie_title
        font.family: regular_font.name
        font.pointSize: 30
        font.underline: true
        font.wordSpacing: 7
        color: big_title_color
        text: is_active ? "Доставка" : "Полученный заказ"

        anchors.top: parent.top
        anchors.left: parent.left

    }

    Rectangle {

        id: order_view_rectangle
        width: 700
        height: 550
        color: "#804c1200"

        anchors.left: deliverie_title.left
        anchors.top: deliverie_title.bottom
        anchors.topMargin: 15

        ListView {

            id: order_items_view
            model: order_view_model
            width: order_view_rectangle.width - 10
            height: 530
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: otder_item_delegate
                width: order_view_rectangle.width-20
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90A84700"

                Image {

                    id: cart_item_image
                    sourceSize.height: 70
                    source: model.image

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 30

                }

                Rectangle {

                    id: number_of_items_rectangle
                    width: number_of_items.paintedWidth * 2
                    height: number_of_items.paintedHeight + 5
                    radius: 5
                    color: "#903F1100"

                    anchors.top: cart_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: cart_item_image.horizontalCenter

                    Text {

                        id: number_of_items
                        text: model.number_of_items
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

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
                        color: regular_text_color
                        font.family: regular_font.name
                        font.pointSize: 20
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                    Text {

                        id: cart_item_description
                        text: model.description
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 18
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.left: cart_item_name.left
                        anchors.top: cart_item_name.bottom
                        anchors.topMargin: 10

                    }

                }

                Text {

                    id: cart_item_price
                    text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽"
                    color: "white"
                    font.family: regular_font.name
                    font.pointSize: 18
                    font.wordSpacing: 5
                    font.bold: true

                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 10

                }


            }


        }

        OrderCancelForm {
            id: order_cancel_form
            anchors.centerIn: parent
        }

    }

    Rectangle {

        id: order_total_rectangle
        width: order_total_title.width*1.2
        height: order_total_title.height*1.2
        color: "#d0290A00"

        anchors.left: order_view_rectangle.left
        anchors.top: order_view_rectangle.bottom
        anchors.topMargin: 20

        Text {

            id: order_total_title
            text: "Итого: "
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 5
            font.bold: true

            anchors.centerIn: parent

        }
    }

    Text {

        id: order_total_value
        text: order_view_model.total_cost/100 + "." + ((order_view_model.total_cost%100 < 10) ?
              order_view_model.total_cost%100 + "0" : order_view_model.total_cost%100) + " ₽"
        color: "white"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5

        anchors.top: order_total_rectangle.top
        anchors.left: order_total_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: order_id_title_rectangle
        width: order_id_title.paintedWidth + 10
        height: order_id_title.paintedHeight + 5
        color: "#d0290A00"

        anchors.top: order_view_rectangle.top
        anchors.left: order_view_rectangle.right
        anchors.leftMargin: 20

        Text {

            id: order_id_title
            text: "Номер заказа:"
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 5

            anchors.centerIn: parent

        }

    }

    Text {

        id: order_id
        text: order_view_model.order_id
        color: "white"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5

        anchors.verticalCenter: order_id_title_rectangle.verticalCenter
        anchors.left: order_id_title_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: receive_code_title_rectangle
        width: receive_code_title.paintedWidth + 10
        height: receive_code_title.paintedHeight + 5
        color: "#d0290A00"

        anchors.top: order_id_title_rectangle.bottom
        anchors.left: order_id_title_rectangle.left
        anchors.topMargin: 5

        Text {

            id: receive_code_title
            text: "Код получения:"
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 5

            anchors.centerIn: parent

        }

    }

    Text {

        id: receive_code
        text: order_view_model.receive_code
        color: "white"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5

        anchors.verticalCenter: receive_code_title_rectangle.verticalCenter
        anchors.left: receive_code_title_rectangle.right
        anchors.leftMargin: 10

    }

    Text {

        id: ordered_timestamp_title
        text: "Дата заказа:"
        color: small_title_color
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        anchors.top: receive_code_title_rectangle.bottom
        anchors.left: receive_code_title_rectangle.left
        anchors.topMargin: 10

    }

    Text {

        id: ordered_timestamp
        text: order_view_model.ordered_timestamp
        color: "white"
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        anchors.verticalCenter: ordered_timestamp_title.verticalCenter
        anchors.left: ordered_timestamp_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: received_timestamp_title
        text: "Дата получения:"
        color: small_title_color
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        visible: !order_view.is_active

        anchors.top: ordered_timestamp_title.bottom
        anchors.left: ordered_timestamp_title.left
        anchors.topMargin: 5

    }

    Text {

        id: received_timestamp
        text: order_view_model.received_timestamp
        color: "white"
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        visible: !order_view.is_active

        anchors.verticalCenter: received_timestamp_title.verticalCenter
        anchors.left: received_timestamp_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: cancel_order_text
        text: "Отменить заказ"
        color: cancel_order_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 16
        font.wordSpacing: 5
        font.bold: true

        visible: order_view.is_active

        layer.enabled: cancel_order_mouse_area.containsMouse
        layer.effect: MultiEffect {

            id: cancle_order_text_shadow
            blurEnabled: true
            blurMax: 12
            blur: 0.6
            saturation: 0.4
            contrast: 0.2

        }

        anchors.bottom: order_view_rectangle.bottom
        anchors.left: order_view_rectangle.right
        anchors.leftMargin: 120

        MouseArea {

            id: cancel_order_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                showOrderCancelForm();

            }

        }

    }

}

