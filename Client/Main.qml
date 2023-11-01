import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {

    id: main_window
    width: 1600
    height: 1000
    visible: true
    title: qsTr("Chilli World")

    property bool logged_in
    property string language

    property string hover_color: "#FDC8B6"
    property string nonhover_color: "white"

    Image {

        id: main_background
        source: "qrc:/Images/backgound.jpg"
        anchors.fill: parent

    }

    Image {

        id: header_image
        width: main_window.width
        source: "qrc:/Images/header_image.jpg"


        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {

            id: logo_text_rect
            width: logo.paintedWidth * 1.25
            height: header_image.height
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

                id: logo
                font.family: logo_font.name
                font.pointSize: 120
                font.bold: true
                text: "Chilli World"
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

            }


        }
    }


    Rectangle {

        id: header_rect
        width: main_window.width - search_column_rect.width - search_column_rect.anchors.margins * 3
        height: 100
        color: "#5d1c01"
        radius: 15

        anchors.top: header_image.bottom
        anchors.topMargin: search_column_rect.anchors.margins
        anchors.left: search_column_rect.right
        anchors.leftMargin: search_column_rect.anchors.margins

        Row {

            id: header_row
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
            spacing: 150

            Text {

                id: sauce_text
                text: "Соусы"
                color: sauce_mouse_area.containsMouse ? hover_color : nonhover_color
                font.family: regular_font.name
                font.pointSize: 25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {

                    id: sauce_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                }

            }

            Text {

                id: sipces_text
                text: "Приправы"
                color: spices_mouse_area.containsMouse ? hover_color : nonhover_color
                font.family: regular_font.name
                font.pointSize: 25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {

                    id: spices_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                }

            }

            Text {

                id: seeds_text
                text: "Семена"
                color: seeds_mouse_area.containsMouse ? hover_color : nonhover_color
                font.family: regular_font.name
                font.pointSize: 25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {

                    id: seeds_mouse_area
                    anchors.fill: parent
                    hoverEnabled: true

                }

            }

        }

    }


    Rectangle {

        id: search_column_rect
        width: 350
        height: 700
        color: "#A0852802"
        radius: 15

        anchors.top: header_image.bottom
        anchors.left: parent.left
        anchors.margins: 20

        Column {

            id: search_column


        }
    }

    FontLoader {

        id: logo_font
        source: "qrc:/Fonts/LogoFont.ttf"

    }

    FontLoader {

        id: regular_font
        source: "qrc:/Fonts/RegularFont.otf"

    }


}

