import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {

    id: main_window
    visibility: "FullScreen"

    title: "Chilli World"

    property string button_color: "#290d00"
    property string button_hovered_color: "#7a2700"
    property string button_text_color: "#E2E2E2"
    property string button_text_hovered_color: "#FF5403"

    StackView {

        id: stack_view
        initialItem: login_page //later must be changed to login_page!
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

    FontLoader {

        id: regular_font
        source: "qrc:/Fonts/RegularFont.otf"

    }

    LoginPage {
        id: login_page
        visible: false
    }

    WorkspacePage {
        id: workspace_page
        visible: false
    }

    ErrorMessage {
        id: error_rectangle
    }

    Connections {

        target: Client
        function onLoggedIn() {

            workspace_page.state = "issuing_orders_list_state";
            stack_view.push(workspace_page);

        }

    }

    Connections {

        target: Client
        function onLogoutConfirmed() {

            login_page.clearAllFields();
            stack_view.pop(login_page);

        }

    }

    onClosing: {

        Client.deleteConnection();

    }

}
