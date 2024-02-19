import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Page {

    id: profile_page
    visible: false

    states: [

        State {

            name: "login_state"

            PropertyChanges {
                target: login_rectangle
                visible: true
            }

            PropertyChanges {
                target: register_rectangle
                visible: false
            }

            PropertyChanges {
                target: orders_form
                visible: false
            }

        },

        State {

            name: "register_state"

            PropertyChanges {
                target: login_rectangle
                visible: false
            }

            PropertyChanges {
                target: register_rectangle
                visible: true
            }

            PropertyChanges {
                target: orders_form
                visible: false
            }

        },

        State {

            name: "orders_state"

            PropertyChanges {
                target: login_rectangle
                visible: false
            }

            PropertyChanges {
                target: register_rectangle
                visible: false
            }

            PropertyChanges {
                target: orders_form
                visible: true
            }

        }

    ]


    signal toMenu();
    signal showMessage(string message_title, string message_description);

    signal setOrderConfirmState();
    signal setDeliveriesState();

    property string button_color: "#290d00"
    property string button_hovered_color: "#7a2700"
    property string button_text_color: "#7a2700"
    property string button_text_hovered_color: "#c23e00"

    property string text_edit_color: "#000000"
    property string text_edit_background_color: "#ae5434"
    property string text_edit_border_color: "#7a2700"

    function clearAuthorizationForms() {

        login_rectangle.clearForms();
        register_rectangle.clearForms();

    }

    function clearOrderModels() {

        active_orders_model.clear();
        received_orders_model.clear();
        order_view_model.clear();

    }

    Connections {

        target: login_rectangle
        function onToRegisterForm() {

            profile_page.state = "register_state"

        }

    }

    Connections {

        target: register_rectangle
        function onToLoginForm() {

            profile_page.state = "login_state"

        }

    }

    Connections {

        target: Client
        function onLoginSuccess(phone_number, name) {

            main_window.logged_in = true;
            orders_form.phone_number = phone_number;
            orders_form.name = name;
            profile_page.state = "orders_state";

            login_rectangle.clearForms();

            if (cart_model.total_price != 0) {

                setOrderConfirmState();

            } else {

                setDeliveriesState();

            }

        }

    }

    Connections {

        target: Client
        function onRegisterSuccess() {

            clearAuthorizationForms();
            toMenu();
            showMessage("Регистрация", "Регистрация прошла успешно!");

        }

    }

    Connections {

        target: Client
        function onLogoutConfirmed() {

            orders_form.name = "";
            orders_form.phone_number = "";
            logged_in = false;
            state = "login_state";
            clearOrderModels();

        }

    }

    Connections {

        target: Client
        function onChangeNameSuccess(name) {

            console.log(name + " new name in qml");
            orders_form.name = name;
            showMessage("Смена имени", "Имя успешно изменено!");

        }

    }

    Connections {

        target: Client
        function onAddActiveOrder(order_id, ordered_timestamp, receive_code, total_cost, order_data, is_ready) {

            var orders_json_array = {"order_positions" : []};

            for (var i = 0; i < order_data.length; ++i) {

                orders_json_array.order_positions.push(order_data[i]);

            }

            active_orders_model.append({ order_id: order_id, ordered_timestamp: ordered_timestamp, receive_code: receive_code,
                                         total_cost: total_cost, order_data: orders_json_array, is_ready: is_ready });

        }

    }

    Connections {

        target: Client
        function onAddReceivedOrder(order_id, ordered_timestamp, received_timestamp, receive_code, total_cost, order_data) {

            var orders_json_array = {"order_positions" : []};

            for (var i = 0; i < order_data.length; ++i) {

                orders_json_array.order_positions.push(order_data[i]);

            }


            received_orders_model.append({ order_id: order_id, ordered_timestamp: ordered_timestamp, received_timestamp: received_timestamp,
                                           receive_code: receive_code, total_cost: total_cost, order_data: orders_json_array });

        }

    }

    Connections {

        target: Client
        function onSetOrderPrepeared(order_id) {

            active_orders_model.setOrderPrepeared(order_id);

        }

    }

    Image {

        id: profile_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Image {

        id: profile_header_image
        width: main_window.width
        source: "qrc:/Images/header_image.jpg"

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {

            id: profile_logo_text_rect
            width: profile_logo.paintedWidth * 1.25
            height: profile_header_image.height

            gradient: Gradient {

                GradientStop { position: 0.0; color: "#30960000" }
                GradientStop { position: 0.05; color: "#90000000" }
                GradientStop { position: 0.5; color: "#d0000000" }
                GradientStop { position: 0.95; color: "#90000000" }
                GradientStop { position: 1.0; color: "#30960000" }
                orientation: Gradient.Horizontal

            }

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


            Text {

                id: profile_logo
                font.family: logo_font.name
                font.pointSize: 120
                font.bold: true
                text: "Chilli World"
                color: "white"

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

            }

        }

        Rectangle {

            id: menu_text_rectangle
            width: menu_text.paintedWidth * 2
            height: profile_header_image.height

            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter

            gradient: Gradient {

                GradientStop { position: 0.0; color: "#30960000" }
                GradientStop { position: 0.05; color: "#90000000" }
                GradientStop { position: 0.5; color: "#d0000000" }
                GradientStop { position: 0.95; color: "#90000000" }
                GradientStop { position: 1.0; color: "#30960000" }
                orientation: Gradient.Horizontal

            }

            Text {

                id: menu_text
                font.family: regular_font.name
                font.pointSize: 30
                font.bold: true
                text: "Меню"
                color: menu_text_mouse_area.containsMouse ? hover_color : "#E2E2E2"
                anchors.centerIn: parent

                layer.enabled: menu_text_mouse_area.containsMouse
                layer.effect: MultiEffect {

                    id: menu_text_shadow
                    blurEnabled: true
                    blurMax: 20
                    blur: 0.7
                    saturation: 0.5
                    contrast: 0.3

                }

                MouseArea {

                    id: menu_text_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {

                        toMenu();

                    }

                }

            }

        }

    }


    LoginForm {
        id: login_rectangle
    }

    RegisterForm {
        id: register_rectangle
        visible: false
    }

    OrdersForm {
        id: orders_form
        visible: false
    }

    ChangeNameForm {
        id: change_name_rectangle
        visible: false
    }

    DeliveriesModel {
        id: active_orders_model
    }

    ReceivedOrdersModel {
        id: received_orders_model
    }

    OrderViewModel {
        id: order_view_model
    }

}
