import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: cart_rectangle
    width: (main_window.width - grid_rectangle.width - anchors.margins*4) / 2
    height: 450
    color: main_window.forms_background_color
    border.width: 2
    border.color: main_window.forms_border_color
    radius: 15

    anchors.top: header_rect.bottom
    anchors.right: parent.right
    anchors.margins: 20

    property bool is_empty: true

    Rectangle {

        id: cart_title_rect
        width: cart_title.paintedWidth * 3
        height: cart_title.paintedHeight

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.25; color: "#809a2901" }
            GradientStop { position: 0.75; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        anchors.horizontalCenter: cart_rectangle.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25

        Text {

            id: cart_title
            text: "Корзина"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: true
            anchors.centerIn: parent

        }

    }

    Canvas
    {
        id: cart_line
        width: cart_title.paintedWidth * 3
        height: 20
        anchors.horizontalCenter: cart_rectangle.horizontalCenter
        anchors.top: cart_title_rect.bottom
        anchors.topMargin: 5

        onPaint:
        {

            var ctx = getContext("2d")

            ctx.strokeStyle = main_window.forms_line_color
            ctx.lineWidth = 8

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Rectangle {

        id: cart_list_rectangle

    }

}
