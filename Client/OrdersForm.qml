import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Item {

    id: orders_form
    width: parent.width
    anchors.top: profile_header_image.bottom
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {

        id: order_header_rectangle
        width: parent.width
        height: 100

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#d01f0800" }
            GradientStop { position: 0.25; color: "#809a2901" }
            GradientStop { position: 0.75; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#d01f0800" }
            orientation: Gradient.Horizontal

        }

        Text {

            id: delivery_text
            text: "Доставки"
            color: delivery_mouse_area.containsMouse ? hover_color : nonhover_color
            font.family: regular_font.name
            font.pointSize: 25
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width/6

            MouseArea {

                id: delivery_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    //header_rect.setSaucesModelSignal();

                }

            }

        }

        Text {

            id: order_history_text
            text: "История заказов"
            color: order_history_mouse_area.containsMouse ? hover_color : nonhover_color
            font.family: regular_font.name
            font.pointSize: 25
            font.wordSpacing: 10
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width/6

            MouseArea {

                id: order_history_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    //header_rect.setSaucesModelSignal();

                }

            }

        }



    }

    Rectangle {

        id: orders_rectangle
        width: 1200
        height: 700
        radius: 15
        color: "#909a2901"
        border.width: 2
        border.color: forms_border_color

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: order_header_rectangle.bottom
        anchors.topMargin: 10
        anchors.horizontalCenterOffset: 100

    }

    Rectangle {

        id: customer_data_rectangle
        width: 280
        height: 200
        radius: 15
        color: "#907D2201"
        border.width: 2
        border.color: forms_border_color

        anchors.top: orders_rectangle.top
        anchors.right: orders_rectangle.left
        anchors.rightMargin: 10

    }


}
