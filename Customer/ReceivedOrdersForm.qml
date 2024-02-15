import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: received_orders_form

    Rectangle {

        id: received_orders_rectangle

        width: 700
        height: 550
        color: "#804c1200"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        Text {

            id: received_orders_empty_title
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 7
            color: "#e4e4e4"
            text: "Здесь пока пусто..."
            anchors.centerIn: parent

            visible: received_orders_model.count === 0

        }

        ListView {

            id: received_orders_view
            model: received_orders_model
            width: received_orders_rectangle.width - 10
            height: 530
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: deliverie_delegate
                width: received_orders_rectangle.width-20
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90431000"
                border.width: 1
                border.color: "#ecbc99"

                Rectangle {

                    id: order_id_title_rectangle
                    width: order_id_title.paintedWidth + 10
                    height: order_id_title.paintedHeight + 5
                    radius: 5
                    color: "#a0290A00"

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 10

                    Text {

                        id: order_id_title
                        text: "Номер заказа: "
                        font.family: regular_font.name
                        font.pointSize: 16
                        color: "#e4e4e4"

                        anchors.centerIn: parent

                    }

                }

                Text {

                    id: order_id
                    anchors.verticalCenter: order_id_title_rectangle.verticalCenter
                    anchors.left: order_id_title_rectangle.right
                    anchors.leftMargin: 10

                    text: model.order_id
                    font.family: regular_font.name
                    font.pointSize: 16
                    color: "#e4e4e4"

                }

                Rectangle {

                    id: order_total_cost_rectangle

                    width: order_total_cost_title.paintedWidth + 10
                    height: order_total_cost_title.paintedHeight + 5
                    radius: 5
                    color: "#a0290A00"

                    anchors.verticalCenter: order_total_cost.verticalCenter
                    anchors.right: order_total_cost.left
                    anchors.rightMargin: 10

                    Text {

                        id: order_total_cost_title

                        text: "Итого:"
                        font.family: regular_font.name
                        font.pointSize: 16
                        color: "#e4e4e4"

                        anchors.centerIn: parent

                    }

                }

                Text {

                    id: order_total_cost

                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 10

                    text: model.total_cost/100 + "." + ((model.total_cost%100 < 10) ?
                          model.total_cost%100 + "0" : model.total_cost%100) + " ₽"
                    font.family: regular_font.name
                    font.pointSize: 16
                    color: "#e4e4e4"

                }


                MouseArea {

                    id: received_order_delegate_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {

                        orders_form.showReceivedOrderView(model.order_id, model.ordered_timestamp, model.received_timestamp,
                                                          model.receive_code, model.order_data, model.total_cost);

                    }

                }

            }
        }

    }

}
