import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Rectangle {

    id: employee_data_rectangle
    width: employee_position.width + employee_name.anchors.leftMargin*4
    height: employee_name.height*3 + employee_name.anchors.topMargin*4
    color: "#d0480000"
    border.width: 1
    border.color: "#7F3A00"
    radius: 10

    anchors.top: parent.top
    anchors.topMargin: 30
    anchors.left: parent.left
    anchors.leftMargin: 25

    Text {

        id: employee_name
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        color: "white"
        text: "Имя: " + workspace_page.name

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

    }

    Text {

        id: employee_surname
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        color: "white"
        text: "Фамилия: " + workspace_page.surname

        anchors.top: employee_name.bottom
        anchors.left: employee_name.left
        anchors.topMargin: 10

    }

    Text {

        id: employee_position
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        color: "white"
        text: "Должность: " + workspace_page.position

        anchors.top: employee_surname.bottom
        anchors.left: employee_surname.left
        anchors.topMargin: 10

    }

    Text {

        id: exit_workspace_test
        font.family: regular_font.name
        font.pointSize: 14
        text: "Выход"
        color: exit_mouse_area.containsMouse ? "#FF5403" : "white"

        anchors.horizontalCenter: employee_data_rectangle.horizontalCenter
        anchors.top: employee_data_rectangle.bottom
        anchors.topMargin: 10

        layer.enabled: exit_mouse_area.containsMouse
        layer.effect: MultiEffect {

            id: exit_workspace_text_shadow
            blurEnabled: true
            blurMax: 12
            blur: 0.6
            saturation: 0.4
            contrast: 0.2

        }

        MouseArea {

            id: exit_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                Client.deleteConnection();
                Qt.callLater(Qt.quit);

            }

        }

    }

}
