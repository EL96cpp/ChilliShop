import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Page {

    id: profile_page
    visible: false

    signal toMenu();

    property string button_color: "#290d00"
    property string button_hovered_color: "#7a2700"
    property string button_text_color: "#7a2700"
    property string button_text_hovered_color: "#c23e00"

    property string text_edit_color: "#000000"
    property string text_edit_background_color: "#ae5434"
    property string text_edit_border_color: "#7a2700"

    Connections {

        target: login_rectangle
        function onToRegisterForm() {

            login_rectangle.visible = false;
            register_rectangle.visible = true;

        }

    }

    Connections {

        target: register_rectangle
        function onToLoginForm() {

            register_rectangle.visible = false;
            login_rectangle.visible = true;

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
        visible: true
    }


    RegisterForm {
        id: register_rectangle
    }


}
