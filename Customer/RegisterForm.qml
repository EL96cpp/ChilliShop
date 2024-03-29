import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects


Rectangle {

    id: register_rectangle
    width: 500
    height: register_circle.height/2 + register_title.paintedHeight + register_title.anchors.topMargin +
            register_name_rect.height*4 + text_edits_distance*3 +  register_name_rect.anchors.topMargin +
            register_button.height + register_button.anchors.topMargin * 2

    visible: false

    color: "#b04a1601"
    radius: 15
    border.width: 5
    border.color: "#4e1800"

    anchors.verticalCenter:  parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    signal toLoginForm();

    function clearForms() {

        register_name_edit.clear();
        register_phone_edit.clear();
        register_password_edit.clear();
        register_password_confirm_edit.clear();

    }

    property int text_edits_point_size: 20
    property int header_texts_point_size: 18
    property int text_edits_distance: 60
    property int header_texts_bottom_margin: 10

    Rectangle {

        id: register_circle
        width: 170
        height: 170
        radius: width/2
        color: "#f9a680"
        border.width: 15
        border.color: "#c23e00"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top

        Image {

            id: circle_pepper_image
            source: "qrc:/Images/pepper.png"
            sourceSize.height: register_circle.height/1.5
            anchors.centerIn: parent

        }

    }

    Text {

        id: register_title
        text: "РЕГИСТРАЦИЯ"
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 20
        font.letterSpacing: 10
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: register_circle.bottom
        anchors.topMargin: 5

    }

    Canvas {

        id: drawingCanvas
        width: register_title.paintedWidth
        height: 100
        anchors.horizontalCenter: register_title.horizontalCenter
        anchors.top: register_title.bottom
        anchors.topMargin: 15

        onPaint: {

            var ctx = getContext("2d")

            ctx.strokeStyle = "#561b00"
            ctx.lineWidth = 10

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Text {

        id: register_name_title
        text: "Введите ваше имя"
        color: regular_text_color
        font.family: regular_font.name
        font.pointSize: header_texts_point_size
        font.wordSpacing: 5

        anchors.bottom: register_name_rect.top
        anchors.bottomMargin: header_texts_bottom_margin
        anchors.left: register_name_rect.left

    }

    Rectangle {

        id: register_name_rect
        width: register_rectangle.width/1.2
        height: register_phone_edit.font.pixelSize * 2
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        color: profile_page.text_edit_background_color
        anchors.top: register_title.bottom
        anchors.topMargin: 90
        anchors.horizontalCenter: register_rectangle.horizontalCenter

        TextInput {

            id: register_name_edit
            color: profile_page.text_edit_color
            font.family: regular_font.name
            font.pointSize: text_edits_point_size
            font.bold: false
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 10

        }
    }

    Text {

        id: register_phone_title
        text: "Номер телефона"
        color: regular_text_color
        font.family: regular_font.name
        font.pointSize: header_texts_point_size
        font.wordSpacing: 5

        anchors.bottom: register_phone_rect.top
        anchors.bottomMargin: header_texts_bottom_margin
        anchors.left: register_phone_rect.left

    }

    Rectangle {

        id: register_phone_rect
        width: register_rectangle.width/1.2
        height: register_phone_edit.font.pixelSize * 2
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        color: profile_page.text_edit_background_color
        anchors.top: register_name_rect.bottom
        anchors.topMargin: text_edits_distance
        anchors.horizontalCenter: register_rectangle.horizontalCenter

        TextInput {

            id: register_phone_edit
            color: profile_page.text_edit_color
            font.family: regular_font.name
            font.pointSize: text_edits_point_size
            font.bold: false
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 10

            validator: RegularExpressionValidator { regularExpression: /^8\d{10}/ }

        }
    }


    Text {

        id: register_password_title
        text: "Придумайте пароль"
        color: regular_text_color
        font.family: regular_font.name
        font.pointSize: header_texts_point_size
        font.wordSpacing: 5

        anchors.bottom: register_password_rect.top
        anchors.bottomMargin: header_texts_bottom_margin
        anchors.left: register_password_rect.left

    }

    Rectangle {

        id: register_password_rect
        width: register_rectangle.width/1.2
        height: register_password_edit.font.pixelSize * 2
        color: profile_page.text_edit_background_color
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        anchors.top: register_phone_rect.bottom
        anchors.topMargin: text_edits_distance
        anchors.horizontalCenter: register_rectangle.horizontalCenter

        TextInput {

            id: register_password_edit
            color: profile_page.text_edit_color
            font.family: regular_font.name
            font.pointSize: text_edits_point_size
            font.bold: false
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 10

            echoMode: TextInput.Password

        }
    }

    Text {

        id: register_password_confirm_title
        text: "Подтвердите  пароль"
        color: regular_text_color
        font.family: regular_font.name
        font.pointSize: header_texts_point_size
        font.wordSpacing: 5

        anchors.bottom: register_password_confirm_rect.top
        anchors.bottomMargin: header_texts_bottom_margin
        anchors.left: register_password_confirm_rect.left

    }

    Rectangle {

        id: register_password_confirm_rect
        width: register_rectangle.width/1.2
        height: register_password_edit.font.pixelSize * 2
        color: profile_page.text_edit_background_color
        border.width: 2
        border.color: profile_page.text_edit_border_color
        radius: 20
        anchors.top: register_password_rect.bottom
        anchors.topMargin: text_edits_distance
        anchors.horizontalCenter: register_rectangle.horizontalCenter

        TextInput {

            id: register_password_confirm_edit
            color: profile_page.text_edit_color
            font.family: regular_font.name
            font.pointSize: text_edits_point_size
            font.bold: false
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 10

            echoMode: TextInput.Password

        }
    }

    Button {

        id: register_button
        width: 200
        height: 35

        anchors.top: register_password_confirm_rect.bottom
        anchors.right: register_rectangle.right
        anchors.rightMargin: 30
        anchors.topMargin: 50

        background: Rectangle {

            color: register_button.hovered ? profile_page.button_hovered_color : profile_page.button_color
            radius: 20

            layer.enabled: register_button.hovered
            layer.effect: MultiEffect {

                id: register_button_rectangle_shadow
                blurEnabled: true
                blurMax: 30
                blur: 0.7
                saturation: 0.5
                contrast: 0.3

            }

        }

        hoverEnabled: true

        contentItem: Text {

            text: "РЕГИСТРАЦИЯ"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: regular_font.name
            font.pointSize: 14
            font.letterSpacing: 5
            font.bold: true
            color: register_button.hovered ? hover_color : "#E2E2E2"
        }

        onClicked: {

            if (register_name_edit.text === "" || register_phone_edit.text === "" ||
                register_password_edit.text === "" || register_password_confirm_edit.text === "") {

                profile_page.showMessage("Ошибка регистрации", "Заполните все необходимые\nполя!");

            } else if (register_password_edit.text !== register_password_confirm_edit.text) {

                profile_page.showMessage("Ошибка регистрации", "Пароли не совпадают!");

            } else {

                Client.onRegister(register_phone_edit.text, register_password_edit.text, register_name_edit.text);

            }

        }

    }

    Text {

        id: login_text
        text: "Авторизация"
        color: login_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 15

        font.letterSpacing: 5
        font.bold: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: register_rectangle.bottom
        anchors.topMargin: 25

        layer.enabled: login_mouse_area.containsMouse
        layer.effect: MultiEffect {

            id: login_text_shadow
            blurEnabled: true
            blurMax: 12
            blur: 0.6
            saturation: 0.4
            contrast: 0.2

        }

        MouseArea {

            id: login_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                toLoginForm();

            }

        }

    }

}
