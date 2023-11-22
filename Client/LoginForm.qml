import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: login_rectangle
    width: 500
    height: 580

    color: "#b04a1601"
    radius: 15
    border.width: 5
    border.color: "#4e1800"

    anchors.top: profile_header_image.bottom
    anchors.topMargin: 100
    anchors.horizontalCenter: parent.horizontalCenter

    signal toRegisterForm();

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

    Canvas
    {
        id: drawingCanvas
        width: login_title.paintedWidth
        height: 100
        anchors.horizontalCenter: login_title.horizontalCenter
        anchors.top: login_title.bottom
        anchors.topMargin: 15

        onPaint:
        {

            var ctx = getContext("2d")

            ctx.strokeStyle = "#561b00"
            ctx.lineWidth = 10

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Text {

        id: login_phone_title
        text: "Номер телефона"
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        anchors.bottom: login_phone_rect.top
        anchors.bottomMargin: 20
        anchors.left: login_phone_rect.left

    }

    Rectangle {

        id: login_phone_rect
        width: login_rectangle.width/1.2
        height: login_phone_input.font.pixelSize * 2
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        color: profile_page.text_edit_background_color
        anchors.top: login_title.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: login_rectangle.horizontalCenter

        TextInput {

            id: login_phone_input
            color: "black"
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            validator: RegularExpressionValidator { regularExpression: /^8\d{10}/ }
        }

    }


    Text {

        id: login_password_title
        text: "Пароль"
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        anchors.bottom: login_password_rect.top
        anchors.bottomMargin: 20
        anchors.left: login_password_rect.left

    }

    Rectangle {

        id: login_password_rect
        width: login_rectangle.width/1.2
        height: login_password_edit.font.pixelSize * 2
        color: profile_page.text_edit_background_color
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        anchors.top: login_phone_rect.bottom
        anchors.topMargin: 70
        anchors.horizontalCenter: login_rectangle.horizontalCenter

        TextInput {

            id: login_password_edit
            color: profile_page.text_edit_color
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            echoMode: TextInput.Password

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

            color: login_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            radius: 20

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

        onClicked: {

            Client.onLogin(login_phone_edit.text, login_password_edit.text);
            console.log("Sent login data to client");

        }

    }

    Text {

        id: register_text
        text: "Регистрация"
        color: register_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 15
        font.letterSpacing: 5
        font.bold: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: login_rectangle.bottom
        anchors.topMargin: 25


        MouseArea {

            id: register_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                toRegisterForm();

            }

        }

    }

}
