import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: orders_form
    width: parent.width
    anchors.top: profile_header_image.bottom
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter

    property string phone_number
    property string name

    function showActiveOrderView(order_id, ordered_timestamp, receive_code, order_data, total_cost, is_ready) {

        order_view_model.clear();

        order_view.is_active = true;

        for (var i = 0; i < order_data.order_positions.length; ++i) {

            console.log(order_data.order_positions[i].id + " " + order_data.order_positions[i].number_of_items);

            order_view_model.append({ product_id: order_data.order_positions[i].id, name: order_data.order_positions[i].name,
                                      description: order_data.order_positions[i].description, price: order_data.order_positions[i].price,
                                      number_of_items: order_data.order_positions[i].number_of_items});

            //image: "file://" + applicationDirPath + "/../Images/Catalog/Seasonings/" + order_data.order_positions[i].id + ".png"

        }

        order_view_model.order_id = order_id;
        order_view_model.receive_code = receive_code;
        order_view_model.ordered_timestamp = ordered_timestamp;
        order_view_model.total_cost = total_cost;
        order_view_model.is_ready = is_ready;

        console.log(order_view_model.order_id + " " + order_view_model.ordered_timestamp + " " + order_view_model.receive_code +
                    " " + order_view_model.total_cost + " " + order_view_model.is_ready);

        order_confirm_form.visible = false;
        deliveries_form.visible = false;
        received_orders_form.visible = false;
        order_view.visible = true;

    }

    Connections {

        target: order_view

        function onShowOrderCancelForm() {

            order_cancel_form.visible = true;

        }

    }

    Connections {

        target: profile_page

        function onSetOrderConfirmState() {

            order_confirm_form.visible = true;
            deliveries_form.visible = false;
            received_orders_form.visible = false;
            order_view.visible = false;

        }

    }

    Connections {

        target: profile_page

        function onSetDeliveriesState() {

            order_confirm_form.visible = false;
            deliveries_form.visible = true;
            received_orders_form.visible = false;
            order_view.visible = false;

        }

    }

    Connections {

        target: Client

        function onOrderAccepted() {

            order_confirm_form.visible = false;
            deliveries_form.visible = true;
            received_orders_form.visible = false;
            order_view.visible = false;

            cart_model.clear();
            cart_model.updateTotalPrice();

        }

    }

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
                hoverEnabled: cart_model.count === 0

                onClicked: {

                    if (cart_model.total_price == 0) {

                        order_confirm_form.visible = false;
                        deliveries_form.visible = true;
                        received_orders_form.visible = false;
                        order_view.visible = false;

                    }

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
                hoverEnabled: cart_model.count === 0

                onClicked: {

                    if (cart_model.total_price == 0) {

                        order_confirm_form.visible = false;
                        deliveries_form.visible = false;
                        received_orders_form.visible = true;
                        order_view.visible = false;

                    }

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
        border.width: 1
        border.color: "#de8a4d"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: order_header_rectangle.bottom
        anchors.topMargin: 10
        anchors.horizontalCenterOffset: 100

        OrderConfirmForm {            
            id: order_confirm_form
        }

        DeliveriesForm {
            id: deliveries_form
            visible: false
        }

        ReceivedOrdersForm {
            id: received_orders_form
            visible: false
        }

        OrderView {
            id: order_view
            visible: false;
        }

    }

    Rectangle {

        id: customer_data_rectangle
        width: 280
        height: customer_name_title.height*2 + customer_name_title.anchors.margins*3
        radius: 15
        color: "#907D2201"
        border.width: 2
        border.color: forms_border_color

        anchors.top: orders_rectangle.top
        anchors.right: orders_rectangle.left
        anchors.rightMargin: 10

        Text {

            id: customer_name_title
            text: "Имя: "
            color: "white"
            font.family: regular_font.name
            font.pointSize: 15
            font.wordSpacing: 5

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10

        }

        Text {

            id: customer_name
            text: orders_form.name
            color: "white"
            font.family: regular_font.name
            font.pointSize: 15
            font.wordSpacing: 5

            anchors.top: customer_name_title.top
            anchors.left: customer_name_title.right

        }

        Text {

            id: customer_phone_title
            text: "Телефон: "
            color: "white"
            font.family: regular_font.name
            font.pointSize: 15
            font.wordSpacing: 5

            anchors.left: customer_name_title.left
            anchors.top: customer_name.bottom
            anchors.topMargin: 10

        }

        Text {

            id: customer_phone
            text: orders_form.phone_number
            color: "white"
            font.family: regular_font.name
            font.pointSize: 15
            font.wordSpacing: 5

            anchors.top: customer_phone_title.top
            anchors.left: customer_phone_title.right

        }

    }

    Text {

        id: change_name_text
        text: "Сменить имя"
        color: change_name_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 12
        font.wordSpacing: 5
        font.bold: false
        anchors.horizontalCenter: customer_data_rectangle.horizontalCenter
        anchors.top: customer_data_rectangle.bottom
        anchors.topMargin: 10

        MouseArea {

            id: change_name_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                change_name_rectangle.visible = true;

            }

        }

    }

    OrderCancelForm {
        id: order_cancel_form
        anchors.centerIn: parent
    }

}
