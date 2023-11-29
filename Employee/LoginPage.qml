import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: login_page

    property int text_input_margins: 80

    Image {

        id: main_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Rectangle {

        id: login_rectangle
        width: main_window.width/3
        height: main_window.height/1.4
        radius: 15
        color: "#90792000"
        border.width: 3
        border.color: "#491300"

        anchors.centerIn: parent

        Rectangle {

            id: circle_rectangle
            width: parent.width/4
            height: width
            radius: width/2
            color: "#f9a680"
            border.width: 15
            border.color: "#c23e00"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top

            Image {

                id: circle_pepper_image
                source: "qrc:/Images/pepper.png"
                sourceSize.height: circle_rectangle.height/1.5
                anchors.centerIn: parent

            }


        }

        Text {

            id: authorization_title
            font.family: regular_font.name
            font.pointSize: 30
            font.bold: true
            font.letterSpacing: 5
            text: "АВТОРИЗАЦИЯ"
            color: "white"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: circle_rectangle.bottom
            anchors.topMargin: 30

        }

        Canvas {

            id: drawingCanvas
            width: authorization_title.paintedWidth * 1.2
            height: 20
            anchors.horizontalCenter: authorization_title.horizontalCenter
            anchors.top: authorization_title.bottom
            anchors.topMargin: 25

            onPaint: {

                var ctx = getContext("2d")

                ctx.strokeStyle = "#300d00"
                ctx.lineWidth = 10

                ctx.beginPath()

                ctx.moveTo(0, 0)
                ctx.lineTo(width, 0)

                ctx.stroke()

            }
        }

        Text {

            id: login_name_title
            font.family: regular_font.name
            font.pointSize: 15
            text: "Имя"
            color: "white"

            anchors.left: login_name_rectangle.left
            anchors.bottom: login_name_rectangle.top
            anchors.bottomMargin: 10

        }

        Rectangle {

            id: login_name_rectangle
            width: parent.width/1.2
            height: login_name_input.font.pixelSize * 2
            radius: 10
            color: "#c66d4d"
            border.width: 2
            border.color: "#451200"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: drawingCanvas.bottom
            anchors.topMargin: text_input_margins/1.5

            TextInput {

                id: login_name_input
                font.family: regular_font.name
                font.pointSize: 20

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10

            }

        }

        Text {

            id: login_surname_title
            font.family: regular_font.name
            font.pointSize: 15
            text: "Фамилия"
            color: "white"

            anchors.left: login_surname_rectangle.left
            anchors.bottom: login_surname_rectangle.top
            anchors.bottomMargin: 10

        }

        Rectangle {

            id: login_surname_rectangle
            width: parent.width/1.2
            height: login_surname_input.font.pixelSize * 2
            radius: 10
            color: "#c66d4d"
            border.width: 2
            border.color: "#451200"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: login_name_rectangle.bottom
            anchors.topMargin: text_input_margins

            TextInput {

                id: login_surname_input
                font.family: regular_font.name
                font.pointSize: 20

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10

            }

        }

        Text {

            id: login_position_title
            font.family: regular_font.name
            font.pointSize: 15
            text: "Должность"
            color: "white"

            anchors.left: login_position_combobox.left
            anchors.bottom: login_position_combobox.top
            anchors.bottomMargin: 10

        }

        ComboBox {

            id: login_position_combobox

            width: parent.width/1.2

            anchors.top: login_surname_rectangle.bottom
            anchors.topMargin: text_input_margins
            anchors.horizontalCenter: login_surname_rectangle.horizontalCenter

            model: ["Оператор", "Меннеджер"]
        }

        Text {

            id: login_password_title
            font.family: regular_font.name
            font.pointSize: 15
            text: "Пароль"
            color: "white"

            anchors.left: login_password_rectangle.left
            anchors.bottom: login_password_rectangle.top
            anchors.bottomMargin: 10

        }

        Rectangle {

            id: login_password_rectangle
            width: parent.width/1.2
            height: login_password_input.font.pixelSize * 2
            radius: 10
            color: "#c66d4d"
            border.width: 2
            border.color: "#451200"

            anchors.top: login_position_combobox.bottom
            anchors.topMargin: text_input_margins
            anchors.horizontalCenter: login_position_combobox.horizontalCenter

            TextInput {

                id: login_password_input
                font.family: regular_font.name
                font.pointSize: 20
                echoMode: TextInput.Password

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10

            }

        }

        Button {

            id: login_button
            width: 200
            height: 50

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 70

            background: Rectangle {

                color: login_button.hovered ? main_window.button_hovered_color : main_window.button_color
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
                color: "#E2E2E2"

            }

            onClicked: {

                Client.onLogin(login_phone_input.text, login_password_input.text);
                console.log("Sent login data to client");

            }

        }

    }

}
