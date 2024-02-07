import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

    id: order_prepearing_form

    width: parent.width/1.8
    height: parent.height/1.1

    anchors.top: parent.top
    anchors.topMargin: 50
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
            font.pointSize: 20
            font.wordSpacing: 5
            font.letterSpacing: 3
            color: "white"
            text: "Заказы"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25

        }

        Rectangle {

            id: order_prepearing_list_rectangle
            width: parent.width - 80
            height: parent.height/1.2
            color: "#c66d4d"

            anchors.top: orders_title.bottom
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {

                id: orders_listview
                width: parent.width
                height: parent.height


            }

        }

    }
}
