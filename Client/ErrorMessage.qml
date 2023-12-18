import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: error_rectangle
    width: main_window.width/4
    height: width/1.8
    radius: 10
    color: "#543d33"
    border.width: 2
    border.color: "#a99e99"

    visible: false

    anchors.centerIn: parent

    property string title : "Error title";
    property string description : "Error description";

    Rectangle {

        id: error_title_rectangle
        width: parent.width - 4
        height: error_title.height * 1.2

        color: "#90000000"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20

        Text {

            id: error_title
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 10
            font.bold: true
            color: "white"
            text: error_rectangle.title

            anchors.centerIn: parent

        }

    }

    Canvas {

        id: lower_line
        width: parent.width - 4
        height: 10
        anchors.horizontalCenter: error_title_rectangle.horizontalCenter
        anchors.top: error_title_rectangle.bottom
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

        id: error_description
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 10
        font.bold: false
        color: "white"
        text: error_rectangle.description

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: error_title_rectangle.bottom
        anchors.topMargin: 30

    }

    Button {

        id: exit_error_button
        width: 100
        height: 40

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30

        background: Rectangle {

            color: exit_error_button.hovered ? "#58504d" : "#100500"
            radius: 20

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
            color: "#E2E2E2"

        }

        onClicked: {

            error_rectangle.title = "";
            error_rectangle.description = "";
            error_rectangle.visible = false;

        }

    }

    Connections {

        target: profile_page
        function onShowErrorMessage(title, description) {

            error_rectangle.title = title;
            error_rectangle.description = description;
            error_rectangle.visible = true;

        }

    }

    Connections {

        target: Client
        function onRegisterError(error_description) {

            error_rectangle.title = "Register error";
            error_rectangle.description = error_description;
            error_rectangle.visible = true;

        }

    }


}
