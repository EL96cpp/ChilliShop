import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Page {

    id: main_page
    visible: true

    Connections {

        target: profile_page
        onToMenu: {

            stack_view.pop(main_page);

        }

    }

    SeedsModel {
        id: seeds_model
    }

    SeasoningsModel {
        id: seasonings_model
    }

    SaucesModel {
        id: sauces_model
    }

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

        Rectangle {

            id: login_rectangle
            width: login_image.width * 3
            height: header_image.height

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: header_image.right
            anchors.rightMargin: 50

            gradient: Gradient {

                GradientStop { position: 0.0; color: "#20960000" }
                GradientStop { position: 0.05; color: "#40000000" }
                GradientStop { position: 0.5; color: "#e0000000" }
                GradientStop { position: 0.95; color: "#40000000" }
                GradientStop { position: 1.0; color: "#20960000" }
                orientation: Gradient.Horizontal

            }


            MouseArea {

                id: login_mouse_area
                anchors.fill: login_image
                hoverEnabled: true

                onClicked: {

                    stack_view.push(profile_page);

                }

            }

            Image {

                id: login_image
                source: "qrc:/Images/profile.png"
                sourceSize.height: logo.paintedHeight / 2.5
                anchors.centerIn: parent

            }

            ColorOverlay {

                anchors.fill: login_image
                source: login_image
                color: login_mouse_area.containsMouse ? hover_color : "#E2E2E2"

            }

        }

    }


    Rectangle {

        id: header_rect
        width: main_window.width
        height: 100
        //color: "#4a1601"

        anchors.top: header_image.bottom
        anchors.topMargin: filters_column_rect.anchors.margins
        anchors.horizontalCenter: parent.horizontalCenter

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#d01f0800" }
            GradientStop { position: 0.25; color: "#809a2901" }
            GradientStop { position: 0.75; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#d01f0800" }
            orientation: Gradient.Horizontal

        }


        Text {

            id: sauce_text
            text: "Соусы"
            color: sauce_mouse_area.containsMouse ? hover_color : nonhover_color
            font.family: regular_font.name
            font.pointSize: 25
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: seasonings_text.left
            anchors.rightMargin: 150

            MouseArea {

                id: sauce_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    goods_grid.model = sauces_model
                }

            }

        }

        Text {

            id: seasonings_text
            text: "Приправы"
            color: seasonings_mouse_area.containsMouse ? hover_color : nonhover_color
            font.family: regular_font.name
            font.pointSize: 25
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {

                id: seasonings_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    goods_grid.model = seasonings_model
                }

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
            anchors.left: seasonings_text.right
            anchors.leftMargin: 150

            MouseArea {

                id: seeds_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    goods_grid.model = seeds_model
                }

            }

        }


    }


    Rectangle {

        id: filters_column_rect
        width: (main_window.width - grid_rectangle.width - anchors.margins*4) / 2
        height: 600
        //color: "#A04a1601"
        color: "#a04a1601"
        radius: 15
        border.width: 2
        border.color: "#4e1800"

        anchors.top: header_rect.bottom
        anchors.left: parent.left
        anchors.margins: 20

        Image {

            id: filters_pepper_image
            source: "qrc:/Images/pepper.png"
            width: 32
            height: 46
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.right: filters_title.left
            anchors.rightMargin: 15
            visible: false

        }

        Text {

            id: filters_title
            text: "Фильтры"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 15
            font.bold: true

            anchors.horizontalCenter: filters_column_rect.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25

        }

        Canvas
        {
            id: filters_column_line
            width: filters_title.paintedWidth * 2.5
            height: 100
            anchors.horizontalCenter: filters_column_rect.horizontalCenter
            anchors.top: filters_title.bottom
            anchors.topMargin: 10

            onPaint:
            {

                var ctx = getContext("2d")

                ctx.strokeStyle = "#6B1F00"
                ctx.lineWidth = 5

                ctx.beginPath()

                ctx.moveTo(0, 0)
                ctx.lineTo(width, 0)

                ctx.stroke()

            }
        }

        Column {

            id: filters_column

        }
    }

    Rectangle {

        id: grid_rectangle
        width: 820
        height: goods_grid.width

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

    Rectangle {

        id: cart_rectangle
        width: (main_window.width - grid_rectangle.width - anchors.margins*4) / 2
        height: 150
        color: "#b04a1601"
        border.width: 2
        border.color: "#4e1800"
        radius: 15

        anchors.top: header_rect.bottom
        anchors.right: parent.right
        anchors.margins: 20

        property bool is_empty: true

        Text {

            id: cart_title
            text: "Корзина"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 15
            font.bold: true

            anchors.horizontalCenter: cart_rectangle.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 15

        }

        Canvas
        {
            id: cart_line
            width: cart_title.paintedWidth * 2.5
            height: 100
            anchors.horizontalCenter: cart_rectangle.horizontalCenter
            anchors.top: cart_title.bottom
            anchors.topMargin: 10

            onPaint:
            {

                var ctx = getContext("2d")

                ctx.strokeStyle = "#6B1F00"
                ctx.lineWidth = 5

                ctx.beginPath()

                ctx.moveTo(0, 0)
                ctx.lineTo(width, 0)

                ctx.stroke()

            }
        }

    }
}
