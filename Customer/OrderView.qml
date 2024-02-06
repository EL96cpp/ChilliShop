import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: order_view

    property int total_cost
    property bool is_active

    Rectangle {

        id: order_view_rectangle
        width: 700
        height: 550
        color: "#804c1200"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        ListView {

            id: order_items_view
            model: order_view_model
            width: order_view_rectangle.width - 10
            height: 530
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            clip: true

            delegate: Rectangle {

                id: otder_item_delegate
                width: order_view_rectangle.width-20
                height: 120
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#90A84700"
                border.width: 1
                border.color: "#ecbc99"

                Image {

                    id: cart_item_image
                    sourceSize.height: 70
                    //source: model.image

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 30

                }


                Text {

                    id: number_of_items
                    height: 20
                    width: 70

                    anchors.top: cart_item_image.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: cart_item_image.horizontalCenter

                }

                Rectangle {

                    id: cart_item_name_rectangle
                    width: cart_item_name.paintedWidth * 1.5
                    height: cart_item_name.paintedHeight

                    anchors.left: cart_item_image.right
                    anchors.leftMargin: 15
                    anchors.top: cart_item_image.top

                    gradient: Gradient {

                        GradientStop { position: 0.0; color: "#303F1100" }
                        GradientStop { position: 0.05; color: "#903F1100" }
                        GradientStop { position: 0.5; color: "#ff3F1100" }
                        GradientStop { position: 0.95; color: "#903F1100" }
                        GradientStop { position: 1.0; color: "#303F1100" }
                        orientation: Gradient.Horizontal

                    }

                    Text {

                        id: cart_item_name
                        text: model.name
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.centerIn: parent

                    }

                    Text {

                        id: cart_item_description
                        text: model.description
                        color: "white"
                        font.family: regular_font.name
                        font.pointSize: 15
                        font.wordSpacing: 5
                        font.bold: true

                        anchors.left: cart_item_name.left
                        anchors.top: cart_item_name.bottom
                        anchors.topMargin: 10

                    }

                }

                Text {

                    id: cart_item_price
                    text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽"
                    color: "white"
                    font.family: regular_font.name
                    font.pointSize: 15
                    font.wordSpacing: 5
                    font.bold: true

                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 10

                }


            }


        }

    }

    Rectangle {

        id: order_total_rectangle
        width: order_total_title.width*1.2
        height: order_total_title.height*1.2
        color: "#d0290A00"

        anchors.left: order_view_rectangle.left
        anchors.top: order_view_rectangle.bottom
        anchors.topMargin: 20

        Text {

            id: order_total_title
            text: "Итого: "
            color: "white"
            font.family: regular_font.name
            font.pointSize: 20
            font.wordSpacing: 5
            font.bold: true

            anchors.centerIn: parent

        }
    }

    Text {

        id: order_total_value
        text: order_view_model.total_cost/100 + "." + ((order_view_model.total_cost%100 < 10) ?
              order_view_model.total_cost%100 + "0" : order_view_model.total_cost%100) + " ₽"
        color: "white"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5

        anchors.top: order_total_rectangle.top
        anchors.left: order_total_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: order_id_title_rectangle
        width: order_id_title.paintedWidth + 10
        height: order_id_title.paintedHeight + 5
        color: "#d0290A00"

        anchors.top: order_view_rectangle.top
        anchors.left: order_view_rectangle.right
        anchors.leftMargin: 20

        Text {

            id: order_id_title
            text: "Номер заказа:"
            color: "white"
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 5

            anchors.centerIn: parent

        }

    }

    Text {

        id: order_id
        text: order_view_model.order_id
        color: "white"
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        anchors.verticalCenter: order_id_title_rectangle.verticalCenter
        anchors.left: order_id_title_rectangle.right
        anchors.leftMargin: 10

    }

    Rectangle {

        id: receive_code_title_rectangle
        width: receive_code_title.paintedWidth + 10
        height: receive_code_title.paintedHeight + 5
        color: "#d0290A00"

        anchors.top: order_id_title_rectangle.bottom
        anchors.left: order_id_title_rectangle.left
        anchors.topMargin: 5

        Text {

            id: receive_code_title
            text: "Код получения:"
            color: "white"
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 5

            anchors.centerIn: parent

        }

    }

    Text {

        id: receive_code
        text: order_view_model.receive_code
        color: "white"
        font.family: regular_font.name
        font.pointSize: 18
        font.wordSpacing: 5

        anchors.verticalCenter: receive_code_title_rectangle.verticalCenter
        anchors.left: receive_code_title_rectangle.right
        anchors.leftMargin: 10

    }

    Text {

        id: ordered_timestamp_title
        text: "Дата заказа:"
        color: "white"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        anchors.top: receive_code_title_rectangle.bottom
        anchors.left: receive_code_title_rectangle.left
        anchors.topMargin: 10

    }

    Text {

        id: ordered_timestamp
        text: order_view_model.ordered_timestamp
        color: "white"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        anchors.verticalCenter: ordered_timestamp_title.verticalCenter
        anchors.left: ordered_timestamp_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: received_timestamp_title
        text: "Дата получения:"
        color: "white"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        visible: !order_view.is_active

        anchors.top: ordered_timestamp_title.bottom
        anchors.left: ordered_timestamp_title.left
        anchors.topMargin: 5

    }

    Text {

        id: received_timestamp
        text: order_view_model.received_timestamp
        color: "white"
        font.family: regular_font.name
        font.pointSize: 15
        font.wordSpacing: 5

        visible: !order_view.is_active

        anchors.horizontalCenter: received_timestamp_title.horizontalCenter
        anchors.left: received_timestamp_title.right
        anchors.leftMargin: 5

    }

    Text {

        id: cancel_order_text
        text: "Отменить заказ"
        color: cancel_order_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        font.bold: true

        visible: order_view.is_active

        anchors.bottom: order_view_rectangle.bottom
        anchors.left: order_view_rectangle.right
        anchors.leftMargin: 120

        MouseArea {

            id: cancel_order_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                order_cancle_form.visible = true;

            }

        }

    }

    Rectangle {

        id: order_cancle_form
        width: main_window.width/4
        height: width/1.8
        radius: 10
        color: "#541500"
        border.width: 2
        border.color: "#7B1C00"

        visible: false

        anchors.centerIn: parent

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
            text: "Вы действительно хотите отменить заказ?"

            wrapMode: Text.WordWrap
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

            }

            hoverEnabled: true

            contentItem: Text {

                id: ok_button_text
                text: "OK"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: regular_font.name
                font.pointSize: 12
                font.letterSpacing: 5
                font.bold: true
                color: order_cancle_ok_button.hovered ? hover_color : "#E2E2E2"

            }

            onClicked: {


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
}

