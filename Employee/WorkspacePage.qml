import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: workspace_page

    property string name: "name";
    property string surname: "surname";
    property string position: "position";

    Image {

        id: workspace_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Rectangle {

        id: workspace_rectangle
        width: parent.width - 300
        height: parent.height - 100
        radius: 30
        anchors.centerIn: parent

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#70792000" }
            GradientStop { position: 0.15; color: "#c0792000" }
            GradientStop { position: 0.5; color: "#d0792000" }
            GradientStop { position: 0.85; color: "#90792000" }
            GradientStop { position: 1.0; color: "#30000000" }
            orientation: Gradient.Horizontal

        }

        Rectangle {

            id: search_rectangle
            width: parent.width/2
            height: parent.height/1.1

            color: "#491300"
            border.width: 1
            border.color: "#7F3A00"
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
                border.color: "#4E2200"

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

            Text {

                id: code_search_title
                font.family: regular_font.name
                font.pointSize: 10
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

            Text {

                id: phone_search_title
                font.family: regular_font.name
                font.pointSize: 10
                color: "white"
                text: "Телефон"

                anchors.horizontalCenter: phone_search_rectangle.horizontalCenter
                anchors.top: phone_search_rectangle.bottom
                anchors.topMargin: 5

            }

            Rectangle {

                id: orders_rectangle
                width: parent.width - 50
                height: parent.height/1.2
                color: "#c66d4d"

                anchors.top: phone_search_title.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                ListView {

                    id: orders_listview
                    width: orders_rectangle.width
                    height: orders_rectangle.height


                }

            }

        }

        Rectangle {

            id: employee_data_rectangle
            width: employee_position.width + employee_name.anchors.leftMargin*4
            height: employee_name.height*3 + employee_name.anchors.topMargin*4
            color: "#d0480000"
            radius: 10

            anchors.top: search_rectangle.top
            anchors.left: parent.left
            anchors.leftMargin: 50

            Text {

                id: employee_name
                font.family: regular_font.name
                font.pointSize: 14
                font.wordSpacing: 5
                color: "white"
                text: "Имя: " + workspace_page.name

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 10
                anchors.leftMargin: 25

            }

            Text {

                id: employee_surname
                font.family: regular_font.name
                font.pointSize: 14
                font.wordSpacing: 5
                color: "white"
                text: "Фамилия: " + workspace_page.surname

                anchors.top: employee_name.bottom
                anchors.left: employee_name.left
                anchors.topMargin: 10

            }

            Text {

                id: employee_position
                font.family: regular_font.name
                font.pointSize: 14
                font.wordSpacing: 5
                color: "white"
                text: "Должность: " + workspace_page.position

                anchors.top: employee_surname.bottom
                anchors.left: employee_surname.left
                anchors.topMargin: 10

            }

        }

    }


}
