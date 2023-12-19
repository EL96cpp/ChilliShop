import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

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
                target: orders_rectanlge
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
                target: orders_rectanlge
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
    signal showErrorMessage(string error_title, string error_description);

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
        function onLoginSuccess() {

            profile_page.state = "orders_state"

        }

    }

    Connections {

        target: Client
        function onRegisterSuccess() {

            clearAuthorizationForms();
            toMenu();
            showErrorMessage("Register result", "Successfully registered!");

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
                font.family: logo_font.name
                font.pointSize: 20
                font.bold: true
                text: "Меню"
                color: menu_text_mouse_area.containsMouse ? hover_color : "#E2E2E2"
                anchors.centerIn: parent

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
    }

}
