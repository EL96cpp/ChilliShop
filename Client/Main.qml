import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Window {

    id: main_window
    width: 1600
    height: 1000
    visible: true
    title: "Chilli World"

    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height

    property bool logged_in: false
    property string language

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

    ErrorMessage {
        id: error_rectangle
    }

    function showErrorMessage(error_title, error_description) {

        error_rectangle.visible = true;

    }

}

