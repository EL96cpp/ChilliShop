import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: custom_spinbox
    color: "transparent"

    property int spinbox_value: 1
    property string buttons_color: "#2d1401"
    property string buttons_border_color: "#c6ad9a"

    signal changeItemCounterSignal(var value);

    Rectangle {

        id: spinbox_minus_rect
        width: custom_spinbox.width/4
        height: custom_spinbox.width/4
        radius: custom_spinbox.width/8
        color: buttons_color
        border.width: 1
        border.color: buttons_border_color

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        Text {

            id: spinbox_minus_text
            font.pixelSize: spinbox_minus_rect.height
            font.bold: true
            color: buttons_border_color
            text: "-"

            anchors.centerIn: parent

        }

        MouseArea {

            id: spinbox_minus_mouse_area
            anchors.fill: parent

            onClicked: {

                if (custom_spinbox.spinbox_value === 0) {

                    return;

                }

                //custom_spinbox.spinbox_value -= 1;
                changeItemCounterSignal(-1);

            }

        }

    }

    Rectangle {

        id: spinbox_value_rectangle
        width: custom_spinbox.width/3
        height: custom_spinbox.height
        anchors.centerIn: parent
        color: "#441d02"

        Text {

            id: spinbox_value_text
            font.pixelSize: spinbox_minus_rect.height
            font.bold: true
            color: "white"
            text: custom_spinbox.spinbox_value
            anchors.centerIn: parent

        }

    }

    Rectangle {

        id: spinbox_plus_rect
        width: custom_spinbox.width/4
        height: custom_spinbox.width/4
        radius: custom_spinbox.width/8
        color: buttons_color
        border.width: 1
        border.color: buttons_border_color

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        Text {

            id: spinbox_plus_text
            font.pixelSize: spinbox_minus_rect.height
            font.bold: true
            color: buttons_border_color
            text: "+"

            anchors.centerIn: parent

        }

        MouseArea {

            id: spinbox_plus_mouse_area
            anchors.fill: parent

            onClicked: {

                //custom_spinbox.spinbox_value += 1;
                changeItemCounterSignal(1);

            }

        }

    }



}
