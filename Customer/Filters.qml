import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle {

    id: filters_column_rect
    width: (main_window.width - grid_rectangle.width - anchors.margins*4) / 2
    height: 680
    color: main_window.forms_background_color
    radius: 15
    border.width: 2
    border.color: main_window.forms_border_color

    anchors.top: header_rect.bottom
    anchors.left: parent.left
    anchors.margins: 20

    property string checkbox_background_color: "#ae5434"
    property string checkbox_select_color: "#ffffff"
    property int titles_pointSize: 15
    property int checkboxes_pointSize: 13

    signal pepperFilterChangedSignal(var pepper_name, var filter_is_active);
    signal sortFilterChangedSignal(var sort_type);
    signal setLowerPriceFilterSignal(var lower_price);
    signal setUpperPriceFilterSignal(var upper_price);
    signal removeFiltersSignal();

    function removeFilters() {

        for (var i = 0; i < pepper_filters_column.children.length; ++i) {

            pepper_filters_column.children[i].checked = false;

        }

        for (var j = 0; j < order_filters_column.children.length; ++j) {

            order_filters_column.children[j].checked = false;

        }

        lower_limit_edit.clear();
        upper_limit_edit.clear();
        removeFiltersSignal();

    }

    Rectangle {

        id: filters_title_rect
        width: filters_title.paintedWidth * 3
        height: filters_title.paintedHeight

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.25; color: "#809a2901" }
            GradientStop { position: 0.75; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        anchors.horizontalCenter: filters_column_rect.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25

        Text {

            id: filters_title
            text: "Фильтры"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: 18
            font.bold: true
            anchors.centerIn: parent

        }
    }

    Canvas
    {
        id: filters_column_line
        width: filters_title.paintedWidth * 3
        height: 10
        anchors.horizontalCenter: filters_column_rect.horizontalCenter
        anchors.top: filters_title_rect.bottom
        anchors.topMargin: 5

        onPaint:
        {

            var ctx = getContext("2d")

            ctx.strokeStyle = main_window.forms_line_color
            ctx.lineWidth = 8

            ctx.beginPath()

            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)

            ctx.stroke()

        }
    }

    Rectangle {

        id: peppers_filter_title_rect
        width: peppers_filter_title.paintedWidth + 20
        height: peppers_filter_title.paintedHeight

        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: filters_column_line.bottom
        anchors.topMargin: 10

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.15; color: "#809a2901" }
            GradientStop { position: 0.85; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        Text {

            id: peppers_filter_title
            text: "Перцы:"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: filters_column_rect.titles_pointSize
            font.bold: true
            anchors.centerIn: parent
        }
    }

    Column {

        id: pepper_filters_column

        anchors.left: peppers_filter_title_rect.left
        anchors.top: peppers_filter_title_rect.bottom
        anchors.topMargin: 10

        CheckBox {

            id: carolina_reaper_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: carolina_reaper_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: carolina_reaper_checkbox.checked
                }
            }

            contentItem: Text {

                id: carolina_reaper_checkbox_text
                text: "Carolina Reaper"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: carolina_reaper_checkbox.indicator.width + carolina_reaper_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    pepperFilterChangedSignal(carolina_reaper_checkbox_text.text, true);

                } else {

                    pepperFilterChangedSignal(carolina_reaper_checkbox_text.text, false);

                }

            }

        }

        CheckBox {

            id: scorpion_moruga_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: scorpion_moruga_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: scorpion_moruga_checkbox.checked
                }
            }

            contentItem: Text {

                id: scorpion_moruga_checkbox_text
                text: "Scorpion Moruga"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: scorpion_moruga_checkbox.indicator.width + scorpion_moruga_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    pepperFilterChangedSignal(scorpion_moruga_checkbox_text.text, true);

                } else {

                    pepperFilterChangedSignal(scorpion_moruga_checkbox_text.text, false);

                }

            }
        }

        CheckBox {

            id: ghost_pepper_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: ghost_pepper_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: ghost_pepper_checkbox.checked
                }
            }

            contentItem: Text {

                id: ghost_pepper_checkbox_text
                text: "Ghost Pepper"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: ghost_pepper_checkbox.indicator.width + ghost_pepper_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    pepperFilterChangedSignal(ghost_pepper_checkbox_text.text, true);

                } else {

                    pepperFilterChangedSignal(ghost_pepper_checkbox_text.text, false);

                }

            }
        }

        CheckBox {

            id: habanero_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: habanero_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: habanero_checkbox.checked
                }
            }

            contentItem: Text {

                id: habanero_checkbox_text
                text: "Habanero"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: habanero_checkbox.indicator.width + habanero_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    pepperFilterChangedSignal(habanero_checkbox_text.text, true);

                } else {

                    pepperFilterChangedSignal(habanero_checkbox_text.text, false);

                }

            }
        }

        CheckBox {

            id: jalapeno_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: jalapeno_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: jalapeno_checkbox.checked
                }
            }

            contentItem: Text {

                id: jalapeno_checkbox_text
                text: "Jalapeno"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: jalapeno_checkbox.indicator.width + jalapeno_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    pepperFilterChangedSignal(jalapeno_checkbox_text.text, true);

                } else {

                    pepperFilterChangedSignal(jalapeno_checkbox_text.text, false);

                }

            }
        }


    }

    Rectangle {

        id: order_filters_title_rect
        width: order_filters_title.paintedWidth + 20
        height: order_filters_title.paintedHeight

        anchors.left: pepper_filters_column.left
        anchors.top: pepper_filters_column.bottom
        anchors.topMargin: 10

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.15; color: "#809a2901" }
            GradientStop { position: 0.85; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        Text {

            id: order_filters_title
            text: "Сортировать по:"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.wordSpacing: 5
            font.pointSize: filters_column_rect.titles_pointSize
            font.bold: true
            anchors.centerIn: parent
        }

    }

    Column {

        id: order_filters_column

        anchors.left: order_filters_title_rect.left
        anchors.top: order_filters_title_rect.bottom
        anchors.topMargin: 10

        CheckBox {

            id: price_increase_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: price_increase_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: price_increase_checkbox.checked
                }
            }

            contentItem: Text {

                text: "Возрастанию цены"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: price_increase_checkbox.indicator.width + price_increase_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    price_decrease_checkbox.checked = false;
                    scoville_decrease_checkbox.checked = false;
                    scoville_increase_checkbox.checked = false;

                    sortFilterChangedSignal("price_increase");

                } else {

                    sortFilterChangedSignal("none");

                }

            }

        }

        CheckBox {

            id: price_decrease_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: price_decrease_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: price_decrease_checkbox.checked
                }
            }

            contentItem: Text {

                text: "Убыванию цены"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: price_decrease_checkbox.indicator.width + price_decrease_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    price_increase_checkbox.checked = false;
                    scoville_decrease_checkbox.checked = false;
                    scoville_increase_checkbox.checked = false;

                    sortFilterChangedSignal("price_decrease");

                } else {

                    sortFilterChangedSignal("none");

                }


            }
        }

        CheckBox {

            id: scoville_increase_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: scoville_increase_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: scoville_increase_checkbox.checked
                }
            }

            contentItem: Text {

                text: "Возрастанию остроты"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize

                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: scoville_increase_checkbox.indicator.width + scoville_increase_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    price_decrease_checkbox.checked = false;
                    price_increase_checkbox.checked = false;
                    scoville_decrease_checkbox.checked = false;

                    sortFilterChangedSignal("scoville_increase");

                } else {

                    sortFilterChangedSignal("none");

                }

            }
        }

        CheckBox {

            id: scoville_decrease_checkbox
            checked: false

            indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: scoville_decrease_checkbox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: filters_column_rect.checkbox_background_color
                border.color: main_window.forms_border_color

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: filters_column_rect.checkbox_select_color
                    visible: scoville_decrease_checkbox.checked
                }
            }

            contentItem: Text {

                text: "Убыванию остроты"
                color: "#E2E2E2"
                font.family: regular_font.name
                font.wordSpacing: 5
                font.pointSize: filters_column_rect.checkboxes_pointSize


                opacity: enabled ? 1.0 : 0.3
                verticalAlignment: Text.AlignVCenter
                leftPadding: scoville_decrease_checkbox.indicator.width + scoville_decrease_checkbox.spacing

            }

            onClicked: {

                if (checked) {

                    price_decrease_checkbox.checked = false;
                    price_increase_checkbox.checked = false;
                    scoville_increase_checkbox.checked = false;

                    sortFilterChangedSignal("scoville_decrease");

                } else {

                    sortFilterChangedSignal("none");

                }

            }
        }
    }

    Rectangle {

        id: limit_filter_rectangle
        width: limit_filter_text.paintedWidth + 20
        height: limit_filter_text.paintedHeight

        gradient: Gradient {

            GradientStop { position: 0.0; color: "#101f0800" }
            GradientStop { position: 0.15; color: "#809a2901" }
            GradientStop { position: 0.85; color: "#809a2901" }
            GradientStop { position: 1.0; color: "#101f0800" }
            orientation: Gradient.Horizontal

        }

        anchors.left: order_filters_column.left
        anchors.top: order_filters_column.bottom
        anchors.topMargin: 40

        Text {

            id: limit_filter_text
            text: "Цена:"
            color: "#E2E2E2"
            font.family: regular_font.name
            font.pointSize: filters_column_rect.titles_pointSize
            anchors.centerIn: parent

        }
    }

    Rectangle {

        id: lower_limit_edit_rectangle
        width: 110
        height: 30
        radius: 5

        color: "#50ae5434"

        anchors.left: limit_filter_rectangle.right
        anchors.leftMargin: 10
        anchors.verticalCenter: limit_filter_rectangle.verticalCenter

        TextEdit {

            id: lower_limit_edit
            color: "#ffffff"
            font.family: regular_font.name
            font.pointSize: 15
            font.bold: false
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.fill: parent

            onTextChanged: {

                if (text === "" || text === "0") {

                    setLowerPriceFilterSignal("0");

                } else {

                    setLowerPriceFilterSignal(text);

                }

            }

        }

    }

    Rectangle {

        id: upper_limit_edit_rectangle
        width: 110
        height: 30
        radius: 5

        color: "#50ae5434"

        anchors.left: lower_limit_edit_rectangle.right
        anchors.leftMargin: 10
        anchors.verticalCenter: lower_limit_edit_rectangle.verticalCenter

        TextEdit {

            id: upper_limit_edit
            color: "#ffffff"
            font.family: regular_font.name
            font.pointSize: 15
            font.bold: false
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.fill: parent

            onTextChanged: {

                if (text === "") {

                    setUpperPriceFilterSignal("-1");

                } else {

                    setUpperPriceFilterSignal(text);

                }

            }

        }
    }


    Text {

        id: lower_limit_text
        text: "От"
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 12
        anchors.horizontalCenter: lower_limit_edit_rectangle.horizontalCenter
        anchors.top: lower_limit_edit_rectangle.bottom
        anchors.topMargin: 5
    }

    Text {

        id: upper_limit_text
        text: "До"
        color: "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 11
        anchors.horizontalCenter: upper_limit_edit_rectangle.horizontalCenter
        anchors.top: upper_limit_edit_rectangle.bottom
        anchors.topMargin: 5
    }

    Text {

        id: remove_filters_text
        text: "Очистить фильтры"
        color: remove_filters_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 11
        font.wordSpacing: 5
        font.bold: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: upper_limit_text.bottom
        anchors.topMargin: 25


        MouseArea {

            id: remove_filters_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                removeFilters();

            }

        }

    }


}
