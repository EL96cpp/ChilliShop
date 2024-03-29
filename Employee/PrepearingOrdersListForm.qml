import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Item {

    id: order_prepearing_form

    width: parent.width/1.8
    height: parent.height/1.1

    anchors.top: employee_data_rectangle.top
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {

        id: order_prepearing_rectangle
        width: parent.width
        height: parent.height

        color: "#491300"
        border.width: 1
        border.color: "#7F3A00"
        radius: 15

        anchors.centerIn: parent

        Text {

            id: orders_title
            font.family: regular_font.name
            font.pointSize: title_font_size
            font.wordSpacing: 5
            font.letterSpacing: 3
            color: "white"
            text: "Сборка заказов"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25

        }

        Rectangle {

            id: order_prepearing_list_rectangle
            width: parent.width - 80
            height: parent.height/1.2
            color: "#c66d4d"
            clip: true

            anchors.top: orders_title.bottom
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {

                id: orders_listview
                width: parent.width
                height: parent.height
                spacing: 5

                model: prepearing_orders_list_model

                delegate: Rectangle {

                    id: order_prepearing_delegate

                    width: order_prepearing_list_rectangle.width
                    height: 120
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: (!model.is_processing &&
                           order_prepearing_delegate_mouse_area.containsMouse) ? "#90902200" : "#90400F00"

                    Rectangle {

                        id: order_id_title_rectangle
                        width: order_id_title.paintedWidth + 10
                        height: order_id_title.paintedHeight + 5
                        radius: 5
                        color: "#a0290A00"

                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: 10

                        Text {

                            id: order_id_title
                            text: "Номер заказа: "
                            font.family: regular_font.name
                            font.pointSize: medium_font_size
                            color: title_color

                            anchors.centerIn: parent

                        }

                    }

                    Text {

                        id: order_id
                        anchors.verticalCenter: order_id_title_rectangle.verticalCenter
                        anchors.left: order_id_title_rectangle.right
                        anchors.leftMargin: 10

                        text: model.order_id
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        color: "#e4e4e4"

                    }

                    Rectangle {

                        id: order_total_cost_rectangle

                        width: order_total_cost_title.paintedWidth + 10
                        height: order_total_cost_title.paintedHeight + 5
                        radius: 5
                        color: "#a0290A00"

                        anchors.verticalCenter: order_total_cost.verticalCenter
                        anchors.right: order_total_cost.left
                        anchors.rightMargin: 10

                        Text {

                            id: order_total_cost_title

                            text: "Итого:"
                            font.family: regular_font.name
                            font.pointSize: medium_font_size
                            color: title_color

                            anchors.centerIn: parent

                        }

                    }

                    Text {

                        id: order_total_cost

                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 10

                        text: model.total_cost/100 + "." + ((model.total_cost%100 < 10) ?
                              model.total_cost%100 + "0" : model.total_cost%100) + " ₽"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        color: "#e4e4e4"

                    }

                    Text {

                        id: is_prepearing_text

                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10

                        visible: model.is_processing

                        text: "ОБРАБАТЫВАЕТСЯ"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        color: "red"

                    }


                    MouseArea {

                        id: order_prepearing_delegate_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {

                            Client.onStartPrepearingOrder(model.order_id);

                        }

                    }

                }


            }

        }

    }

}
