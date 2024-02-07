import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {

    id: workspace_page

    property string name: "name";
    property string surname: "surname";
    property string position: "position";

    Image {

        id: workspace_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Rectangle {

        id: workspace_rectangle
        width: parent.width - 300
        height: parent.height - 100
        radius: 30
        anchors.centerIn: parent

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#70792000" }
            GradientStop { position: 0.15; color: "#c0792000" }
            GradientStop { position: 0.5; color: "#d0792000" }
            GradientStop { position: 0.85; color: "#90792000" }
            GradientStop { position: 1.0; color: "#30000000" }
            orientation: Gradient.Horizontal

        }

        states:  [

            State {

                name: "order_issuing_state"

                PropertyChanges {
                    target: order_issuing_form
                    visible: true
                }

                PropertyChanges {
                    target: order_prepearing_form
                    visible: false
                }

                PropertyChanges {
                    target: order_issuing_text
                    visible: false
                }

                PropertyChanges {
                    target: order_prepearing_text
                    visible: true
                }

            },

            State {

                name: "order_prepearing_state"

                PropertyChanges {
                    target: order_issuing_form
                    visible: false
                }

                PropertyChanges {
                    target: order_prepearing_form
                    visible: true
                }

                PropertyChanges {
                    target: order_issuing_text
                    visible: true
                }

                PropertyChanges {
                    target: order_prepearing_text
                    visible: false
                }

            }

        ]


        OrderIssuingForm {
            id: order_issuing_form
        }

        OrderPrepearingForm {
            id: order_prepearing_form
            visible: false
        }

        OrderIssuingModel {
            id: order_issuing_model
        }

        OrderPrepearingModel {
            id: order_prepearing_model
        }

        EmployeeDataForm {
            id: employee_data_rectangle
        }


        Text {

            id: order_prepearing_text
            font.family: regular_font.name
            font.pointSize: 12
            font.wordSpacing: 5
            text: "Сборка заказов"
            color: order_prepearing_mouse_area.containsMouse ? "#FF5403" : "white"

            anchors.top: employee_data_rectangle.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 150

            MouseArea {

                id: order_prepearing_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    workspace_rectangle.state = "order_prepearing_state";

                }

            }

        }

        Text {

            id: order_issuing_text
            font.family: regular_font.name
            font.pointSize: 12
            font.wordSpacing: 5
            text: "Выдача заказов"
            color: order_issuing_mouse_area.containsMouse ? "#FF5403" : "white"

            visible: false

            anchors.top: employee_data_rectangle.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 150

            MouseArea {

                id: order_issuing_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    workspace_rectangle.state = "order_issuing_state";

                }

            }

        }

    }

    Connections {

        target: Client
        function onLoggedIn(name, surname, position) {

            workspace_page.name = name;
            workspace_page.surname = surname;
            workspace_page.position = position;

        }

    }

}
