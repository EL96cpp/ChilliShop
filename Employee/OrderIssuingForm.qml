import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

    id: order_issuing_form

    width: parent.width/1.8
    height: parent.height/1.1

    anchors.top: parent.top
    anchors.topMargin: 50
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {

        id: order_issuing_rectangle
        width: parent.width
        height: parent.height

        color: "#49281d"
        border.width: 1
        border.color: "#7F3A00"
        radius: 15

        anchors.centerIn: parent

        Rectangle {

            id: search_rectangle
            width: orders_rectangle.width
            height: code_search_rectangle.height + code_search_title.paintedHeight +
                    code_search_rectangle.anchors.topMargin + code_search_title.anchors.topMargin*2
            radius: 10
            color: "#622510"
            border.width: 1
            border.color: "#b66549"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30

            Rectangle {

                id: code_search_rectangle
                width: code_search_input.font.pixelSize * 5
                height: code_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#4E2200"

                anchors.left: search_rectangle.left
                anchors.top: parent.top
                anchors.leftMargin: 40
                anchors.topMargin: 10

                TextInput {

                    id: code_search_input
                    font.family: regular_font.name
                    font.pointSize: 20
                    font.letterSpacing: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                    validator: RegularExpressionValidator { regularExpression: /\d{4}/ }

                }

            }

            Text {

                id: code_search_title
                font.family: regular_font.name
                font.pointSize: 14
                font.wordSpacing: 5
                color: "white"
                text: "Код заказа"

                anchors.horizontalCenter: code_search_rectangle.horizontalCenter
                anchors.top: code_search_rectangle.bottom
                anchors.topMargin: 5

            }

            Rectangle {

                id: phone_search_rectangle
                width: phone_search_input.font.pixelSize * 20
                height: phone_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#4E2200"

                anchors.right: search_rectangle.right
                anchors.top: parent.top
                anchors.rightMargin: 40
                anchors.topMargin: 10

                TextInput {

                    id: phone_search_input
                    font.family: regular_font.name
                    font.pointSize: 20
                    font.letterSpacing: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 25

                    validator: RegularExpressionValidator { regularExpression: /^8\d{10}/ }

                }

            }

            Text {

                id: phone_search_title
                font.family: regular_font.name
                font.pointSize: 14
                color: "white"
                text: "Телефон"

                anchors.horizontalCenter: phone_search_rectangle.horizontalCenter
                anchors.top: phone_search_rectangle.bottom
                anchors.topMargin: 5

            }

        }

        Rectangle {

            id: orders_rectangle
            width: parent.width - 80
            height: parent.height/1.25
            color: "#c66d4d"

            anchors.top: search_rectangle.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {

                id: orders_listview

                width: orders_rectangle.width
                height: orders_rectangle.height

                model: order_issuing_model

                delegate: Rectangle {

                    id: order_issuing_delegate

                    width: orders_rectangle.width-20
                    height: 120
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#90431000"
                    border.width: 1
                    border.color: "#ecbc99"

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
                            font.pointSize: 16
                            color: "#e4e4e4"

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
                        font.pointSize: 16
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
                            font.pointSize: 16
                            color: "#e4e4e4"

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
                        font.pointSize: 16
                        color: "#e4e4e4"

                    }

                    Text {

                        id: order_ready_title

                        text: "Готов к выдаче:"
                        font.family: regular_font.name
                        font.pointSize: 16
                        font.wordSpacing: 5
                        color: "#e4e4e4"

                        anchors.right: check_box_rectangle.left
                        anchors.top: order_total_cost.bottom
                        anchors.topMargin: 25
                        anchors.rightMargin: 10

                    }

                    MouseArea {

                        id: order_issuing_delegate_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {


                        }

                    }

                }

            }

        }
    }

}
