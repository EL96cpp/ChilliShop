import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: deliveries_form

    signal showActiveOrder();

    Rectangle {

        id: deliveries_rectangle
        width: 700
        height: 550
        color: "#909a2901"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        Text {

            id: deliveries_empty_title
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 7
            color: "#e4e4e4"
            text: "Здесь пока пусто..."
            anchors.centerIn: parent

            visible: active_orders_model.count === 0

        }

        ListView {

            id: deliveries_view
            model: active_orders_model
            width: deliveries_rectangle.width - 10
            height: 530
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: deliverie_delegate
                width: deliveries_rectangle.width
                height: 120
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90431000"

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

                Text {

                    id: order_ready_title

                    text: "Готов к выдаче:"
                    font.family: regular_font.name
                    font.pointSize: 16
                    font.wordSpacing: 5
                    color: "#e4e4e4"

                    anchors.right: check_box_rectangle.left
                    anchors.top: order_total_cost.bottom
                    anchors.topMargin: 25
                    anchors.rightMargin: 10

                }

                Rectangle {

                    id: check_box_rectangle
                    width: 30
                    height: 30
                    radius: 5
                    color: "#290A00"

                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: order_ready_title.verticalCenter

                    Image {

                        id: check_box_image
                        source: "qrc:/Images/check_box_mark.png"
                        width: parent.width-5
                        height: parent.height-5
                        visible: model.is_ready

                        anchors.centerIn: parent


                    }

                }

                MouseArea {

                    id: deliverie_delegate_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {

                        orders_form.showActiveOrderView(model.order_id, model.ordered_timestamp, model.receive_code,
                                                        model.order_data, model.total_cost, model.is_ready);

                    }

                }

            }
        }
    }

}
