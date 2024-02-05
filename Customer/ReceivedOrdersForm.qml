import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


Item {

    id: received_orders_form

    Rectangle {

        id: received_orders_rectangle

        width: 700
        height: 550
        color: "#804c1200"

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        Text {

            id: deliveries_empty_title
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 7
            color: "#e4e4e4"
            text: "Здесь пока пусто..."
            anchors.centerIn: parent

            visible: received_orders_model.count === 0

        }

    }

}
