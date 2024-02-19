import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Rectangle {

    id: good_delegate_rectange
    width: 450
    height: good_delegate_image.paintedHeight + good_delegate_title_rect.height +
            good_delegate_scoville.paintedHeight + good_delegate_description.paintedHeight +
            good_delegate_title.anchors.margins + add_to_cart_button.height +
            add_to_cart_button.anchors.margins + 30

    radius: 15
    clip: true

    Layout.minimumWidth: 450
    Layout.minimumHeight: height
    Layout.maximumWidth: 450
    Layout.maximumHeight: height

    signal addToCartSignal(var id, var name, var type, var text_description, var price, var image);

    Component.onCompleted: {

        addToCartSignal.connect(grid_rectangle.addToCartSignal);

    }

    gradient: Gradient {

        GradientStop { position: 0.0; color: "#d01f0800" }
        GradientStop { position: 0.35; color: "#d03e1000" }
        GradientStop { position: 0.5; color: "#d04d1501" }
        GradientStop { position: 0.95; color: "#909a2901" }
        GradientStop { position: 1.0; color: "#806c1d01" }
        orientation: Gradient.Horizontal

    }

    Image {

        id: good_delegate_image
        sourceSize.width: parent.width
        fillMode: Image.PreserveAspectFit
        source: model.image
        anchors.top: parent.top

    }

    Rectangle {

        id: good_delegate_title_rect
        anchors.top: good_delegate_image.bottom
        anchors.left: good_delegate_image.left
        anchors.margins: 10
        color: "#a06c1d01"
        width: good_delegate_title.paintedWidth + 10
        height: good_delegate_title.paintedHeight

        Text {

            id: good_delegate_title
            color: small_title_color
            anchors.centerIn: parent
            font.family: regular_font.name
            font.pointSize: 22
            font.wordSpacing: 10
            font.bold: true
            text: model.name

        }

    }

    Text {

        id: good_delegate_description
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 16
        font.wordSpacing: 5
        font.bold: true
        text: model.text_description
        anchors.top: good_delegate_title_rect.bottom
        anchors.left: good_delegate_title_rect.left

    }    

    Text {

        id: good_delegate_scoville
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 14
        font.wordSpacing: 5
        font.bold: false
        text: "Острота: " + model.scoville + " shu"
        anchors.top: good_delegate_description.bottom
        anchors.left: good_delegate_description.left

    }

    Text {

        id: good_delegate_price
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 20
        font.wordSpacing: 5
        font.bold: true
        text: model.price/100 + "." + ((model.price%100 < 10) ? model.price%100 + "0" : model.price%100) + " ₽"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20

    }

    Button {

        id: add_to_cart_button
        width: add_to_cart_text.paintedWidth + 30
        height: add_to_cart_text.paintedHeight + 10

        anchors.bottom: good_delegate_rectange.bottom
        anchors.right: good_delegate_rectange.right
        anchors.margins: 20

        background: Rectangle {

            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            color: add_to_cart_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            radius: 20

            layer.enabled: add_to_cart_button.hovered
            layer.effect: MultiEffect {

                id: add_to_cart_button_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

        }

        hoverEnabled: true

        contentItem: Text {

            id: add_to_cart_text
            text: "В корзину"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 18
            font.wordSpacing: 5
            font.bold: true
            color: add_to_cart_button.hovered ? hover_color : "#E2E2E2"
        }

        onClicked: {

            addToCartSignal(model.id, model.name, model.type, model.text_description, model.price, model.image);

        }

    }

}
