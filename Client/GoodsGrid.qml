import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: grid_rectangle
    width: 820
    height: 700

    color: "#00000000"

    anchors.top: header_rect.bottom
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter

    Component.onCompleted: {

        console.log(width);

    }


    GridView {

        id: goods_grid
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        cellWidth: 410
        cellHeight: 580

        clip: true

        model: sauces_model

        delegate: GoodDelegate {
            id: good_delegate_rectange
        }




    }

}
