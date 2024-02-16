import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Rectangle {

    id: issuing_order_form

    width: parent.width/1.8
    height: parent.height/1.1
    radius: 10
    color: "#909a2901"
    border.width: 1
    border.color: "#de8a4d"

    anchors.top: employee_data_rectangle.top
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {

        id: issuing_order_rectangle
        width: parent.width - 100
        height: parent.height - 100
        color: "#804c1200"

        anchors.centerIn: parent

        ListView {

            id: issuing_order_view
            model: issuing_order_model
            width: issuing_order_rectangle.width - 10
            height: 730
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: issuing_order_item_delegate
                width: issuing_order_rectangle.width-20
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90A84700"
                border.width: 1
                border.color: "#ecbc99"

                Image {

                    id: issuing_item_image
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

                    anchors.top: issuing_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: issuing_item_image.horizontalCenter

                    Text {

                        id: number_of_items
                        text: model.number_of_items
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 14
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                }

                Rectangle {

                    id: issuing_item_name_rectangle
                    width: issuing_item_name.paintedWidth * 1.5
                    height: issuing_item_name.paintedHeight

                    anchors.left: issuing_item_image.right
                    anchors.leftMargin: 15
                    anchors.top: issuing_item_image.top

                    gradient: Gradient {

                        GradientStop { position: 0.0; color: "#303F1100" }
                        GradientStop { position: 0.05; color: "#903F1100" }
                        GradientStop { position: 0.5; color: "#ff3F1100" }
                        GradientStop { position: 0.95; color: "#903F1100" }
                        GradientStop { position: 1.0; color: "#303F1100" }
                        orientation: Gradient.Horizontal

                    }

                    Text {

                        id: issuing_item_name
                        text: model.name
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                    Text {

                        id: issuing_item_description
                        text: model.description
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.left: issuing_item_name.left
                        anchors.top: issuing_item_name.bottom
                        anchors.topMargin: 10

                    }

                }

                Text {

                    id: issuing_item_price
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

    Text {

        id: to_issuing_orders_list_text
        color: to_issuing_orders_list_mouse_area.containsMouse ? "#FF5403" : "white"
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5
        font.bold: true
        text: "К спискy заказов"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors.top: issuing_order_form.top
        anchors.horizontalCenter: issue_order_button.horizontalCenter

        layer.enabled: to_issuing_orders_list_mouse_area.containsMouse
        layer.effect: MultiEffect {

            id: to_issuing_orders_list_text_shadow
            blurEnabled: true
            blurMax: 12
            blur: 0.6
            saturation: 0.4
            contrast: 0.2

        }

        MouseArea {

            id: to_issuing_orders_list_mouse_area
            hoverEnabled: true
            anchors.fill: parent

            onClicked: {

                Client.onStopIssuingOrder(issuing_order_model.order_id);

            }

        }

    }

    Button {

        id: issue_order_button
        width: 210
        height: 50

        anchors.left: issuing_order_form.right
        anchors.bottom: issuing_order_form.bottom
        anchors.leftMargin: 55

        background: Rectangle {

            color: issue_order_button.hovered ? "#7a2700" : "#290d00"
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: issue_order_button.hovered
            layer.effect: MultiEffect {

                id: issue_order_button_shadow
                blurEnabled: true
                blurMax: 30
                blur: 0.7
                saturation: 0.5
                contrast: 0.3

            }

        }

        hoverEnabled: true

        contentItem: Text {

            text: "Выдать заказ"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 15
            font.wordSpacing: 5
            font.bold: true
            color: issue_order_button.hovered ? "#c23e00" : "#E2E2E2"

        }

        onClicked: {

            Client.onOrderReceivedMessage(issuing_order_model.order_id, issuing_order_model.phone_number, issuing_order_model.receive_code);

        }

    }

}
