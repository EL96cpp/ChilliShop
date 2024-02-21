import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Rectangle {

    id: employee_data_rectangle
    width: Math.max(employee_name_title.paintedWidth, employee_surname_title.paintedWidth, employee_position_title.paintedWidth) +
           employee_name_title.anchors.leftMargin*2 +
           Math.max(employee_name.paintedWidth, employee_surname.paintedWidth, employee_position.paintedWidth) +
           employee_name.anchors.leftMargin
    height: employee_name_title.paintedHeight*3 + employee_name_title.anchors.topMargin*4
    color: "#d0480000"
    border.width: 1
    border.color: "#7F3A00"
    radius: 10

    Text {

        id: employee_name_title
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: title_color
        text: "Имя:"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 25

    }

    Text {

        id: employee_name
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: "white"
        text: workspace_page.name

        anchors.verticalCenter: employee_name_title.verticalCenter
        anchors.left: employee_name_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: employee_surname_title
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: title_color
        text: "Фамилия:"

        anchors.top: employee_name_title.bottom
        anchors.left: employee_name_title.left
        anchors.topMargin: 10

    }

    Text {

        id: employee_surname
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: "white"
        text: workspace_page.surname

        anchors.verticalCenter: employee_surname_title.verticalCenter
        anchors.left: employee_surname_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: employee_position_title
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: title_color
        text: "Должность:"

        anchors.top: employee_surname_title.bottom
        anchors.left: employee_surname_title.left
        anchors.topMargin: 10

    }

    Text {

        id: employee_position
        font.family: regular_font.name
        font.pointSize: small_font_size
        font.wordSpacing: 5
        color: "white"
        text: workspace_page.position

        anchors.verticalCenter: employee_position_title.verticalCenter
        anchors.left: employee_position_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: exit_workspace_test
        font.family: regular_font.name
        font.pointSize: small_font_size
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

                if (!issuing_order_form.visible && !prepearing_order_form.visible) {

                    Client.onLogout();

                } else {

                    workspace_page.showMessage("Ошибка логгирования!", "Завершите обработку зазака!");

                }

            }

        }

    }

}
