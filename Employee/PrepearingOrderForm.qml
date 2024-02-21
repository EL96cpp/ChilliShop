import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Rectangle {

    id: prepearing_order_form

    width: parent.width/1.8
    height: parent.height/1.1
    radius: 10
    color: "#909a2901"
    border.width: 1
    border.color: "#de8a4d"

    anchors.top: employee_data_rectangle.top
    anchors.horizontalCenter: parent.horizontalCenter

    signal prepeareOrderError();

    Rectangle {

        id: prepearing_order_rectangle
        width: parent.width - 100
        height: parent.height - 100
        color: "#804c1200"

        anchors.centerIn: parent

        ListView {

            id: prepearing_order_view
            model: prepearing_order_model
            width: prepearing_order_rectangle.width - 10
            height: 730
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: prepearing_order_item_delegate
                width: prepearing_order_rectangle.width
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90A84700"

                Image {

                    id: prepearing_item_image
                    sourceSize.height: 70
                    source: model.image

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 30

                }

                Rectangle {

                    id: number_of_items_rectangle
                    width: number_of_items.paintedWidth * 4
                    height: number_of_items.paintedHeight + 5
                    radius: 5
                    color: "#903F1100"

                    anchors.top: prepearing_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: prepearing_item_image.horizontalCenter

                    Text {

                        id: number_of_items
                        text: model.number_of_items
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                }

                Rectangle {

                    id: prepearing_item_name_rectangle
                    width: prepearing_item_name.paintedWidth * 1.5
                    height: prepearing_item_name.paintedHeight

                    anchors.left: prepearing_item_image.right
                    anchors.leftMargin: 15
                    anchors.top: prepearing_item_image.top

                    gradient: Gradient {

                        GradientStop { position: 0.0; color: "#303F1100" }
                        GradientStop { position: 0.05; color: "#903F1100" }
                        GradientStop { position: 0.5; color: "#ff3F1100" }
                        GradientStop { position: 0.95; color: "#903F1100" }
                        GradientStop { position: 1.0; color: "#303F1100" }
                        orientation: Gradient.Horizontal

                    }

                    Text {

                        id: prepearing_item_name
                        text: model.name
                        color: title_color
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                    Text {

                        id: prepearing_item_description
                        text: model.description
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.left: prepearing_item_name.left
                        anchors.top: prepearing_item_name.bottom
                        anchors.topMargin: 10

                    }

                }

                Text {

                    id: prepeared_text_title
                    text: "Добавлен\nв заказ"
                    color: "white"
                    font.family: regular_font.name
                    font.pointSize: medium_font_size
                    font.wordSpacing: 5
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter

                    anchors.verticalCenter: prepeared_check_box_rectangle.verticalCenter
                    anchors.right: prepeared_check_box_rectangle.left
                    anchors.rightMargin: 15

                }

                Rectangle {

                    id: prepeared_check_box_rectangle
                    width: 30
                    height: 30
                    radius: 5
                    color: "#290A00"

                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 20

                    Image {

                        id: prepeared_check_box_image
                        source: "qrc:/Images/check_box_mark.png"
                        width: parent.width-5
                        height: parent.height-5
                        visible: model.prepeared

                        anchors.centerIn: parent


                    }

                    MouseArea {

                        id: prepeared_check_box_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {

                            model.prepeared = !model.prepeared;

                        }

                    }

                }

                Text {

                    id: prepearing_item_price
                    text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽"
                    color: "white"
                    font.family: regular_font.name
                    font.pointSize: medium_font_size
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

        id: to_prepearing_orders_list_text
        color: to_prepearing_orders_list_mouse_area.containsMouse ? "#FF5403" : "white"
        font.family: regular_font.name
        font.pointSize: big_font_size
        font.wordSpacing: 5
        font.bold: true
        text: "К спискy заказов"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors.top: prepearing_order_form.top
        anchors.horizontalCenter: set_prepeared_order_button.horizontalCenter

        layer.enabled: to_prepearing_orders_list_mouse_area.containsMouse
        layer.effect: MultiEffect {

            id: to_prepearing_orders_list_text_shadow
            blurEnabled: true
            blurMax: 12
            blur: 0.6
            saturation: 0.4
            contrast: 0.2

        }

        MouseArea {

            id: to_prepearing_orders_list_mouse_area
            hoverEnabled: true
            anchors.fill: parent

            onClicked: {

                Client.onStopPrepearingOrder(prepearing_order_model.order_id);

            }

        }

    }

    Rectangle {

        id: order_id_rectangle
        width: order_id_title.paintedWidth + 10
        height: order_id_title.paintedHeight + 10
        color: "#290A00"

        anchors.top: to_prepearing_orders_list_text.bottom
        anchors.left: prepearing_order_form.right
        anchors.topMargin: 25
        anchors.leftMargin: 10

        Text {

            id: order_id_title
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: medium_font_size
            font.wordSpacing: 5
            font.bold: true
            text: "Номер заказа:"

            anchors.centerIn: parent

        }

    }

    Text {

        id: order_id_text
        color: "white"
        font.family: regular_font.name
        font.pointSize: medium_font_size
        font.wordSpacing: 5
        font.bold: true
        text: prepearing_order_model.order_id

        anchors.verticalCenter: order_id_rectangle.verticalCenter
        anchors.left: order_id_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: ordered_timestamp_rectangle
        width: ordered_timestamp_title.paintedWidth + 10
        height: ordered_timestamp_title.paintedHeight + 10
        color: "#290A00"

        anchors.left: order_id_rectangle.left
        anchors.top: order_id_rectangle.bottom
        anchors.topMargin: 10

        Text {

            id: ordered_timestamp_title
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: medium_font_size
            font.wordSpacing: 5
            font.bold: true
            text: "Дата заказа:"

            anchors.centerIn: parent

        }

    }

    Text {

        id: ordered_timestamp_text
        color: "white"
        font.family: regular_font.name
        font.pointSize: medium_font_size
        font.wordSpacing: 5
        font.bold: true
        text: prepearing_order_model.ordered_timestamp

        anchors.verticalCenter: ordered_timestamp_rectangle.verticalCenter
        anchors.left: ordered_timestamp_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: phone_number_rectangle
        width: phone_number_title.paintedWidth + 10
        height: phone_number_title.paintedHeight + 10
        color: "#290A00"

        anchors.left: ordered_timestamp_rectangle.left
        anchors.top: ordered_timestamp_rectangle.bottom
        anchors.topMargin: 10

        Text {

            id: phone_number_title
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: medium_font_size
            font.wordSpacing: 5
            font.bold: true
            text: "Номер телефона:"

            anchors.centerIn: parent

        }

    }

    Text {

        id: phone_number_text
        color: "white"
        font.family: regular_font.name
        font.pointSize: medium_font_size
        font.wordSpacing: 5
        font.bold: true
        text: prepearing_order_model.phone_number

        anchors.verticalCenter: phone_number_rectangle.verticalCenter
        anchors.left: phone_number_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: total_cost_rectangle
        width: total_cost_title.paintedWidth + 10
        height: total_cost_title.paintedHeight + 10
        color: "#290A00"

        anchors.left: phone_number_rectangle.left
        anchors.top: phone_number_rectangle.bottom
        anchors.topMargin: 10

        Text {

            id: total_cost_title
            color: small_title_color
            font.family: regular_font.name
            font.pointSize: medium_font_size
            font.wordSpacing: 5
            font.bold: true
            text: "Итого:"

            anchors.centerIn: parent

        }

    }

    Text {

        id: total_cost_text
        color: "white"
        font.family: regular_font.name
        font.pointSize: medium_font_size
        font.wordSpacing: 5
        font.bold: true
        text: prepearing_order_model.total_cost/100 + "." + ((prepearing_order_model.total_cost%100 < 10) ?
              prepearing_order_model.total_cost%100 + "0" : prepearing_order_model.total_cost%100) + " ₽"

        anchors.verticalCenter: total_cost_rectangle.verticalCenter
        anchors.left: total_cost_rectangle.right
        anchors.leftMargin: 10

    }

    Button {

        id: set_prepeared_order_button
        width: 210
        height: 50

        anchors.left: prepearing_order_form.right
        anchors.bottom: prepearing_order_form.bottom
        anchors.leftMargin: 55

        background: Rectangle {

            color: set_prepeared_order_button.hovered ? "#7a2700" : "#290d00"
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: set_prepeared_order_button.hovered
            layer.effect: MultiEffect {

                id: set_prepeared_order_button_shadow
                blurEnabled: true
                blurMax: 30
                blur: 0.7
                saturation: 0.5
                contrast: 0.3

            }

        }

        hoverEnabled: true

        contentItem: Text {

            text: "Заказ собран"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: medium_font_size
            font.wordSpacing: 5
            font.bold: true
            color: set_prepeared_order_button.hovered ? "#c23e00" : "#E2E2E2"

        }

        onClicked: {

            if (prepearing_order_model.checkIfAllItemsPrepeared()) {

                Client.onOrderPrepearedMessage(prepearing_order_model.order_id, prepearing_order_model.phone_number, prepearing_order_model.receive_code);

            } else {

                prepeareOrderError();

            }

        }

    }


}
