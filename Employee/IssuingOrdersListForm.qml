import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Item {

    id: order_issuing_form

    width: parent.width/1.8
    height: parent.height/1.1

    anchors.top: employee_data_rectangle.top
    anchors.horizontalCenter: parent.horizontalCenter

    function setModelCopy() {

        if (issuing_orders_list_model_copy.count !== 0) {

            issuing_orders_list_model_copy.clear();

        }

        for (var i = 0; i < issuing_orders_list_model.count; ++i) {

            issuing_orders_list_model_copy.append(issuing_orders_list_model.get(i));

        }

    }

    function updateCopyModel() {

        setModelCopy();
        filterByReceiveCode();
        filterByPhoneNumber();

    }

    function filterByReceiveCode() {

        if (issuing_orders_list_model_copy.code_mask.length !== 0) {

            var filtered_orders_counter = 0;

            for (var j = 0; j < issuing_orders_list_model_copy.count; ++j) {

                if (issuing_orders_list_model_copy.get(j).receive_code.startsWith(issuing_orders_list_model_copy.code_mask)) {

                    issuing_orders_list_model_copy.move(j, filtered_orders_counter, 1);
                    ++filtered_orders_counter;

                }

            }

            if (filtered_orders_counter === 0) {

                issuing_orders_list_model_copy.clear();

            } else if (filtered_orders_counter !== issuing_orders_list_model_copy.count) {

                issuing_orders_list_model_copy.remove(filtered_orders_counter, issuing_orders_list_model_copy.count - filtered_orders_counter);

            }

        }

    }

    function filterByPhoneNumber() {

        if (issuing_orders_list_model_copy.phone_mask.length !== 0) {

            var filtered_orders_counter = 0;

            for (var j = 0; j < issuing_orders_list_model_copy.count; ++j) {

                if (issuing_orders_list_model_copy.get(j).phone_number.startsWith(issuing_orders_list_model_copy.phone_mask)) {

                    issuing_orders_list_model_copy.move(j, filtered_orders_counter, 1);
                    ++filtered_orders_counter;

                }

            }

            if (filtered_orders_counter === 0) {

                issuing_orders_list_model_copy.clear();

            } else if (filtered_orders_counter !== issuing_orders_list_model_copy.count) {

                issuing_orders_list_model_copy.remove(filtered_orders_counter, issuing_orders_list_model_copy.count - filtered_orders_counter);

            }

        }

    }

    Connections {

        target: workspace_page
        function addIssuingOrderToCopyModel(order_id, ordered_timestamp, receive_code, phone_number, total_cost, order_array) {

            updateCopyModel();

        }

    }


    Rectangle {

        id: order_issuing_rectangle
        width: parent.width
        height: parent.height

        color: "#49281d"
        border.width: 1
        border.color: "#7F3A00"
        radius: 15

        anchors.centerIn: parent

        Rectangle {

            id: search_rectangle
            width: orders_rectangle.width
            height: code_search_rectangle.height + code_search_title.paintedHeight +
                    code_search_rectangle.anchors.topMargin + code_search_title.anchors.topMargin*2
            radius: 10
            color: "#622510"
            border.width: 1
            border.color: "#b66549"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30

            Rectangle {

                id: code_search_rectangle
                width: code_search_input.font.pixelSize * 5
                height: code_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#4E2200"

                anchors.left: search_rectangle.left
                anchors.top: parent.top
                anchors.leftMargin: 40
                anchors.topMargin: 10

                TextInput {

                    id: code_search_input
                    font.family: regular_font.name
                    font.pointSize: medium_font_size
                    font.letterSpacing: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                    validator: RegularExpressionValidator { regularExpression: /\d{4}/ }

                    onTextChanged: {

                        issuing_orders_list_model_copy.code_mask = code_search_input.text;
                        updateCopyModel();

                    }

                }

            }

            Text {

                id: code_search_title
                font.family: regular_font.name
                font.pointSize: medium_font_size
                font.wordSpacing: 5
                color: "white"
                text: "Код заказа"

                anchors.horizontalCenter: code_search_rectangle.horizontalCenter
                anchors.top: code_search_rectangle.bottom
                anchors.topMargin: 5

            }

            Rectangle {

                id: phone_search_rectangle
                width: phone_search_input.font.pixelSize * 20
                height: phone_search_input.font.pixelSize * 2
                radius: 10
                color: "#c66d4d"
                border.width: 2
                border.color: "#4E2200"

                anchors.right: search_rectangle.right
                anchors.top: parent.top
                anchors.rightMargin: 40
                anchors.topMargin: 10

                TextInput {

                    id: phone_search_input
                    font.family: regular_font.name
                    font.pointSize: medium_font_size
                    font.letterSpacing: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 25

                    validator: RegularExpressionValidator { regularExpression: /^8\d{10}/ }

                    onTextChanged: {

                        issuing_orders_list_model_copy.phone_mask = phone_search_input.text;
                        updateCopyModel();

                    }

                }

            }

            Text {

                id: phone_search_title
                font.family: regular_font.name
                font.pointSize: medium_font_size
                color: "white"
                text: "Телефон"

                anchors.horizontalCenter: phone_search_rectangle.horizontalCenter
                anchors.top: phone_search_rectangle.bottom
                anchors.topMargin: 5

            }

        }

        Rectangle {

            id: orders_rectangle
            width: parent.width - 80
            height: parent.height/1.25
            color: "#c66d4d"
            clip: true

            anchors.top: search_rectangle.bottom
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {

                id: orders_listview

                width: orders_rectangle.width
                height: orders_rectangle.height
                spacing: 5

                model: issuing_orders_list_model_copy

                delegate: Rectangle {

                    id: order_issuing_delegate

                    width: orders_rectangle.width
                    height: order_id_title_rectangle.height + order_id_title_rectangle.anchors.margins +
                            phone_number_title_rectangle.height + phone_number_title_rectangle.anchors.topMargin*2
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: (!model.is_processing &&
                           order_issuing_delegate_mouse_area.containsMouse) ? "#90902200" : "#90400F00"

                    Rectangle {

                        id: order_id_title_rectangle
                        width: order_id_title.paintedWidth + 10
                        height: order_id_title.paintedHeight + 5
                        radius: 5
                        color: "#a0290A00"

                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: 10

                        Text {

                            id: order_id_title
                            text: "Номер заказа: "
                            font.family: regular_font.name
                            font.pointSize: medium_font_size
                            font.wordSpacing: 5
                            color: title_color

                            anchors.centerIn: parent

                        }

                    }

                    Text {

                        id: order_id
                        anchors.verticalCenter: order_id_title_rectangle.verticalCenter
                        anchors.left: order_id_title_rectangle.right
                        anchors.leftMargin: 10

                        text: model.order_id
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        color: "#e4e4e4"

                    }

                    Rectangle {

                        id: phone_number_title_rectangle
                        width: phone_number_title.paintedWidth + 10
                        height: phone_number_title.paintedHeight + 5
                        radius: 5
                        color: "#a0290A00"

                        anchors.left: order_id_title_rectangle.left
                        anchors.top: order_id_title_rectangle.bottom
                        anchors.topMargin: 10

                        Text {

                            id: phone_number_title
                            text: "Номер телефона: "
                            font.family: regular_font.name
                            font.pointSize: medium_font_size
                            font.wordSpacing: 5
                            color: title_color

                            anchors.centerIn: parent

                        }

                    }

                    Text {

                        id: phone_number
                        anchors.verticalCenter: phone_number_title_rectangle.verticalCenter
                        anchors.left: phone_number_title_rectangle.right
                        anchors.leftMargin: 10

                        text: model.phone_number
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        color: "#e4e4e4"

                    }

                    Rectangle {

                        id: order_total_cost_rectangle

                        width: order_total_cost_title.paintedWidth + 10
                        height: order_total_cost_title.paintedHeight + 5
                        radius: 5
                        color: "#a0290A00"

                        anchors.verticalCenter: order_total_cost.verticalCenter
                        anchors.right: order_total_cost.left
                        anchors.rightMargin: 10

                        Text {

                            id: order_total_cost_title

                            text: "Итого:"
                            font.family: regular_font.name
                            font.pointSize: medium_font_size
                            font.wordSpacing: 5
                            color: title_color

                            anchors.centerIn: parent

                        }

                    }

                    Text {

                        id: order_total_cost

                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 10

                        text: model.total_cost/100 + "." + ((model.total_cost%100 < 10) ?
                              model.total_cost%100 + "0" : model.total_cost%100) + " ₽"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        color: "#e4e4e4"

                    }

                    Text {

                        id: is_issuing_text

                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10

                        visible: model.is_processing

                        text: "ОБРАБАТЫВАЕТСЯ"
                        font.family: regular_font.name
                        font.pointSize: medium_font_size
                        font.wordSpacing: 5
                        color: "red"

                    }

                    MouseArea {

                        id: order_issuing_delegate_mouse_area
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {

                            Client.onStartIssuingOrder(model.order_id);

                        }

                    }

                }

            }

        }
    }

}
