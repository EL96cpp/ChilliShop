import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {

    id: main_window
    visibility: "FullScreen"
    title: "Chilli World"

    property bool logged_in: false

    property string hover_color: "#FF5403"
    property string nonhover_color: "white"

    property string forms_background_color: "#b04a1601"
    property string forms_border_color: "#4e1800"
    property string forms_line_color: "#561b00"

    StackView {

        id: stack_view
        initialItem: main_page
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 1
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 1
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 1
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 1
            }
        }

    }


    MainPage {
        id: main_page
    }

    ProfilePage {
        id: profile_page
    }



    FontLoader {

        id: logo_font
        source: "qrc:/Fonts/LogoFont.ttf"

    }

    FontLoader {

        id: regular_font
        source: "qrc:/Fonts/RegularFont.otf"

    }

    CartModel {

        id: cart_model

    }

    Message {
        id: message_rectangle
    }

    function showMessage(message_title, message_description) {

        message_rectangle.visible = true;

    }

}

