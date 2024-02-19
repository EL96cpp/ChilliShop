import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Rectangle {

    id: message_rectangle
    width: main_window.width/3.7
    height: message_title_rectangle.height + message_title_rectangle.anchors.topMargin +
            message_description.paintedHeight + message_description.anchors.topMargin +
            exit_message_button.height + exit_message_button.anchors.topMargin*4
    radius: 10
    color: "#541500"
    border.width: 2
    border.color: "#7B1C00"

    visible: false

    anchors.centerIn: parent

    property string title : "Error title";
    property string description : "Error description";

    Rectangle {

        id: message_title_rectangle
        width: parent.width - 4
        height: message_title.height * 1.2

        color: "#90000000"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20

        Text {

            id: message_title
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 10
            font.bold: true
            color: title_color
            text: message_rectangle.title

            anchors.centerIn: parent

        }

    }

    Canvas {

        id: lower_line
        width: parent.width - 4
        height: 10
        anchors.horizontalCenter: message_title_rectangle.horizontalCenter
        anchors.top: message_title_rectangle.bottom
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

        id: message_description
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 10
        font.bold: false
        color: "white"
        text: message_rectangle.description
        horizontalAlignment: Text.AlignHCenter
        width: parent.width - anchors.topMargin*2

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: message_title_rectangle.bottom
        anchors.topMargin: 30

    }

    Button {

        id: exit_message_button
        width: 100
        height: 40

        anchors.right: parent.right
        anchors.top: message_description.bottom
        anchors.topMargin: 10
        anchors.rightMargin: 30

        background: Rectangle {

            color: exit_message_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: exit_message_button.hovered
            layer.effect: MultiEffect {

                id: exit_message_button_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

        }

        hoverEnabled: true

        contentItem: Text {

            id: button_text
            text: "OK"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: exit_message_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            message_rectangle.title = "";
            message_rectangle.description = "";
            message_rectangle.visible = false;

        }

    }

    Connections {

        target: profile_page
        function onShowMessage(title, description) {

            message_rectangle.title = title;
            message_rectangle.description = description;
            message_rectangle.visible = true;

        }

    }

    Connections {

        target: Client
        function onShowMessage(title, description) {

            message_rectangle.title = title;
            message_rectangle.description = description;
            message_rectangle.visible = true;

        }

    }

}
