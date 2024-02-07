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


            }

        }
    }

}
