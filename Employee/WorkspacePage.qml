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
        radius: 30
        anchors.centerIn: parent

        Rectangle {

            id: search_rectangle
            width: phone_search_rectangle.width + code_search_rectangle.width +
                   code_search_rectangle.anchors.leftMargin * 3
            height: phone_search_rectangle.height + phone_search_rectangle.anchors.topMargin * 2

            color: "#c05e1902"
            border.width: 1
            border.color: "#FFDACB"
            radius: 15

            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {

                id: code_search_rectangle
                width: code_search_input.font.pixelSize * 5
                height: code_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#451200"

                anchors.left: search_rectangle.left
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 20

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

            Rectangle {

                id: phone_search_rectangle
                width: phone_search_input.font.pixelSize * 20
                height: phone_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#451200"

                anchors.left: code_search_rectangle.right
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 20

                TextInput {

                    id: phone_search_input
                    font.family: regular_font.name
                    font.pointSize: 20
                    font.letterSpacing: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                    validator: RegularExpressionValidator { regularExpression: /^8\d{10}/ }

                }

            }

        }

    }


}
