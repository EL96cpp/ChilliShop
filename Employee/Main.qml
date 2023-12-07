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

    StackView {

        id: stack_view
        initialItem: workspace_page
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
    }

    ErrorMessage {
        id: error_rectangle
    }

    Connections {

        target: Client
        function onLoggedIn() {

            stack_view.push(workspace_page);

        }

    }

    Connections {

        target: Client
        function onShowErrorMessage(title, description) {

            error_rectangle.title = title;
            error_rectangle.description = description;
            error_rectangle.visible = true;

        }

    }

    onClosing: {

        Client.deleteConnection();

    }

}
