import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: workspace_page

    Image {

        id: workspace_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Rectangle {

        id: workspace_rectangle
        width: parent.width - 300
        height: parent.height - 100
        color: "#c0792000"
        border.width: 2
        border.color: "#491300"
        radius: 10
        anchors.centerIn: parent

        Rectangle {

            id: phone_search_rectangle
            width: parent.width/3
            height: login_surname_input.font.pixelSize * 2
            radius: 10
            color: "#c66d4d"
            border.width: 2
            border.color: "#451200"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login_name_rectangle.bottom
            anchors.topMargin: text_input_margins

            TextInput {

                id: phone_search_input
                font.family: regular_font.name
                font.pointSize: 20

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10

            }

        }


    }


}
