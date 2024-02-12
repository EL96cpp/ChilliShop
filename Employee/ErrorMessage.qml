import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {

    id: error_rectangle
    width: main_window.width/4
    height: width/2
    radius: 10
    color: "#431100"
    border.width: 2
    border.color: "#7B1C00"


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
        horizontalAlignment: Text.AlignHCenter

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

            color: exit_error_button.hovered ? main_window.button_hovered_color : main_window.button_color
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
            color: exit_error_button.hovered ? main_window.button_text_hovered_color : main_window.button_text_color

        }

        onClicked: {

            error_rectangle.title = "";
            error_rectangle.description = "";
            error_rectangle.visible = false;

        }

    }

    Connections {

        target: Client
        function onShowErrorMessage(title, description) {

            error_rectangle.title = title;
            error_rectangle.description = description;
            error_rectangle.visible = true;

        }

    }

    Connections {

        target: login_page
        function onShowErrorMessage(title, description) {

            error_rectangle.title = title;
            error_rectangle.description = description;
            error_rectangle.visible = true;

        }

    }

    Connections {

        target: workspace_page
        function onPrepeareOrderError() {

            error_rectangle.title = "Ошибка подготовки заказа";
            error_rectangle.description = "Добавьте все необходимые\nтовары в заказ!";
            error_rectangle.visible = true;

        }

    }

}
