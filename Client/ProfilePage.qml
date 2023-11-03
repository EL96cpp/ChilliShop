import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Page {

    id: profile_page
    visible: true

    Image {

        id: profile_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Image {

        id: profile_header_image
        width: main_window.width
        source: "qrc:/Images/header_image.jpg"


        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {

            id: profile_logo_text_rect
            width: profile_logo.paintedWidth * 1.25
            height: profile_header_image.height

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#30960000" }
                GradientStop { position: 0.05; color: "#90000000" }
                GradientStop { position: 0.5; color: "#d0000000" }
                GradientStop { position: 0.95; color: "#90000000" }
                GradientStop { position: 1.0; color: "#30960000" }
                orientation: Gradient.Horizontal
            }

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


            Text {

                id: profile_logo
                font.family: logo_font.name
                font.pointSize: 120
                font.bold: true
                text: "Chilli World"
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

            }


        }

    }

    Rectangle {

        id: login_rectangle
        width: 500
        height: 580

        color: "#A04a1601"
        radius: 15
        border.width: 2
        border.color: "#4e1800"

        anchors.top: profile_header_image.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {

            id: circle
            width: 170
            height: 170
            radius: width/2
            color: "#f9a680"
            border.width: 15
            border.color: "#c23e00"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top

            Image {

                id: circle_pepper_image
                source: "qrc:/Images/pepper.png"
                sourceSize.height: circle.height/1.5
                anchors.centerIn: parent

            }

        }

        Text {

            id: login_title
            text: "АВТОРИЗАЦИЯ"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 25
            font.letterSpacing: 10
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: circle.bottom
            anchors.topMargin: 5

        }

        Text {

            id: login_phone_title
            text: "Номер телефона"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 15

            anchors.bottom: login_phone_rect.top
            anchors.bottomMargin: 20
            anchors.left: login_phone_rect.left

        }

        Rectangle {

            id: login_phone_rect
            width: login_rectangle.width/1.2
            height: login_phone_edit.paintedHeight * 1.2
            border.width: 2
            border.color: "#7a2700"
            radius: 20
            color: "#491700"
            anchors.top: login_title.bottom
            anchors.topMargin: 100
            anchors.horizontalCenter: login_rectangle.horizontalCenter

            TextEdit {

                id: login_phone_edit
                color: "#E2E2E2"
                font.family: regular_font.name
                font.pointSize: 25
                font.bold: false
                anchors.fill: parent
                anchors.left: parent.left
                anchors.leftMargin: 10

            }
        }


        Text {

            id: login_password_title
            text: "Пароль"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 15

            anchors.bottom: login_password_rect.top
            anchors.bottomMargin: 20
            anchors.left: login_password_rect.left

        }

        Rectangle {

            id: login_password_rect
            width: login_rectangle.width/1.2
            height: login_password_edit.paintedHeight * 1.2
            color: "#491700"
            border.width: 2
            border.color: "#7a2700"
            radius: 20
            anchors.top: login_phone_rect.bottom
            anchors.topMargin: 70
            anchors.horizontalCenter: login_rectangle.horizontalCenter

            TextEdit {

                id: login_password_edit
                color: "#E2E2E2"
                font.family: regular_font.name
                font.pointSize: 25
                font.bold: false
                anchors.fill: parent
                anchors.left: parent.left
                anchors.leftMargin: 10

            }
        }

        Button {

            id: login_button
            width: 150
            height: 50

            anchors.right: login_password_rect.right
            anchors.top: login_password_rect.bottom
            anchors.topMargin: 50

            background: Rectangle {

                color: login_button.hovered ? "#46271a" : "#310f00"
                radius: 20
                border.width: 2
                border.color: "#611f00"

            }

            hoverEnabled: true

            contentItem: Text {

                text: "ВХОД"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: regular_font.name
                font.pointSize: 12
                font.letterSpacing: 5
                font.bold: true
                color: login_button.hovered ? hover_color : "#E2E2E2"

            }

        }

    }

    Text {

        id: register_text
        text: "Регистрация"
        color: register_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 15
        font.letterSpacing: 5
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: login_rectangle.bottom
        anchors.topMargin: 25


        MouseArea {

            id: register_mouse_area
            anchors.fill: parent
            hoverEnabled: true

        }

    }

}
