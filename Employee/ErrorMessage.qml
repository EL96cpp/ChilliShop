import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {

    id: error_rectangle
    width: main_window.width/4
    height: width/2
    radius: 10
    color: "#c0c34000"

    visible: true

    anchors.centerIn: parent

    property string title : "kekeer";
    property string description : "Error description";

    Text {

        id: error_title
        font.family: regular_font.name
        font.pointSize: 20
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
        font.bold: false
        color: "white"
        text: error_rectangle.description

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: error_title.bottom
        anchors.topMargin: 25

    }

}
