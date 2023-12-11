import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {

    id: error_rectangle
    width: main_window.width/4
    height: width/2
    radius: 10
    color: "#3f1300"
    border.width: 2
    border.color: "#7F3A00"

    visible: false

    anchors.centerIn: parent

    property string title : "Error title";
    property string description : "Error description";

    Text {

        id: error_title
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 10
        font.bold: true
        color: "white"
        text: error_rectangle.title

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30

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
        anchors.top: error_title.bottom
        anchors.topMargin: 25

    }

    Button {

        id: exit_error_button
        width: 200
        height: 50

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        background: Rectangle {

            color: exit_error_button.hovered ? main_window.button_hovered_color : main_window.button_color
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

}
