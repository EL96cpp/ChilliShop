import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: deliveries_form

    Rectangle {

        id: deliveries_rectangle

        width: 700
        height: 550
        color: "#804c1200"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        Text {

            text: "deliveries"
            color: "white"

            anchors.centerIn: parent

        }

    }

}
