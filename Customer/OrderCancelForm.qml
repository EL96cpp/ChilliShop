import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Rectangle {

    id: order_cancle_form
    width: main_window.width/3.9
    height: width/1.6
    radius: 10
    color: "#541500"
    border.width: 2
    border.color: "#7B1C00"

    visible: false

    signal cancelOrder(var order_id, var phone_number, var receive_code);

    Rectangle {

        id: order_cancle_rectangle
        width: parent.width - 4
        height: order_cancle_title.height * 1.2

        color: "#90000000"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20

        Text {

            id: order_cancle_title
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 10
            font.bold: true
            color: "white"
            text: "Отмена заказа"

            anchors.centerIn: parent

        }

    }

    Canvas {

        id: lower_line
        width: parent.width - 4
        height: 10
        anchors.horizontalCenter: order_cancle_rectangle.horizontalCenter
        anchors.top: order_cancle_rectangle.bottom
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

        id: order_cancle_question
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 10
        font.bold: false
        color: "white"
        text: "Вы действительно хотите\nотменить заказ?"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width - anchors.topMargin*2

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: order_cancle_rectangle.bottom
        anchors.topMargin: 30

    }

    Button {

        id: order_cancle_ok_button
        width: 100
        height: 40

        anchors.right: order_cancle_cancle_button.left
        anchors.verticalCenter: order_cancle_cancle_button.verticalCenter
        anchors.rightMargin: 10

        background: Rectangle {

            color: order_cancle_ok_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: order_cancle_ok_button.hovered
            layer.effect: MultiEffect {

                id: order_cancle_ok_button_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

        }

        hoverEnabled: true

        contentItem: Text {

            id: ok_button_text
            text: "Да"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: order_cancle_ok_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            Client.onCancelOrder(order_view_model.order_id, orders_form.phone_number, order_view_model.receive_code);
            order_cancel_form.visible = false;

        }

    }

    Button {

        id: order_cancle_cancle_button
        width: 100
        height: 40

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30

        background: Rectangle {

            color: order_cancle_cancle_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            border.width: 1
            border.color: "#7D2000"
            radius: 20

            layer.enabled: order_cancle_cancle_button.hovered
            layer.effect: MultiEffect {

                id: order_cancle_cancle_button_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

        }

        hoverEnabled: true

        contentItem: Text {

            id: order_cancle_cancle_button_text
            text: "Отмена"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 12
            font.letterSpacing: 5
            font.bold: true
            color: order_cancle_cancle_button.hovered ? hover_color : "#E2E2E2"

        }

        onClicked: {

            order_cancle_form.visible = false;

        }

    }

}
