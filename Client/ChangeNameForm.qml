import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: change_name_rectangle
    width: 400
    height: 300
    color: "#BF3500"
    radius: 10

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {

        id: change_name_title_rectangle
        width: change_name_title.width*1.5
        height: change_name_title.height+10

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#20960000" }
            GradientStop { position: 0.05; color: "#40000000" }
            GradientStop { position: 0.5; color: "#e0000000" }
            GradientStop { position: 0.95; color: "#40000000" }
            GradientStop { position: 1.0; color: "#20960000" }
            orientation: Gradient.Horizontal

        }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10

        Text {

            id: change_name_title
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 10
            font.bold: true
            color: "white"
            text: "Изменение имени"

            anchors.centerIn: parent


        }

    }

    Canvas {

        id: lower_line
        width: parent.width - 4
        height: 10
        anchors.horizontalCenter: change_name_title_rectangle.horizontalCenter
        anchors.top: change_name_title_rectangle.bottom
        anchors.topMargin: 5

        onPaint: {

            var ctx = getContext("2d")

            ctx.strokeStyle = "#90000000"
            ctx.lineWidth = 10

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Text {

        id: change_name_text
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 10
        font.bold: true
        color: "white"
        text: "Новое имя:"

        anchors.top: lower_line.bottom
        anchors.left: parent.left
        anchors.margins: 10

    }

    Rectangle {

        id: new_name_rectangle
        width: change_name_rectangle.width/1.8
        height: new_name_input.font.pixelSize * 1.5
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        color: profile_page.text_edit_background_color
        anchors.verticalCenter: change_name_text.verticalCenter
        anchors.left: change_name_text.right
        anchors.leftMargin: 10

        TextInput {

            id: new_name_input
            color: "black"
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            validator: RegularExpressionValidator { regularExpression: /[a-zA-Z]{16}/ }

        }

    }

    Button {

        id: exit_button
        width: 150
        height: 50

        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.topMargin: 20

        background: Rectangle {

            color: exit_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            radius: 20

        }

        hoverEnabled: true

        contentItem: Text {

            text: "ВЫХОД"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: exit_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            new_name_input.text = ""
            change_name_rectangle.visible = false;

        }

    }

    Button {

        id: change_name_button
        width: 150
        height: 50

        anchors.right: parent.right
        anchors.bottom: exit_button.top
        anchors.topMargin: 20

        background: Rectangle {

            color: change_name_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            radius: 20

        }

        hoverEnabled: true

        contentItem: Text {

            text: "Сменить имя"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: change_name_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            if (new_name_input.text === "") {

                profile_page.showErrorMessage("Change name error", "Feel all required fields!");

            } else {

                Client.onChangeName(new_name_input.text);

            }

        }

    }

}
