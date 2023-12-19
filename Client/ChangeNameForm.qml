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

}
