import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Effects

Page {

    id: workspace_page

    property string name: "name";
    property string surname: "surname";
    property string position: "position";

    signal showMessage(var messate_title, var message_description);

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

                name: "issuing_orders_list_state"

                PropertyChanges {
                    target: issuing_orders_list_form
                    visible: true
                }

                PropertyChanges {
                    target: prepearing_orders_list_form
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

                PropertyChanges {
                    target: issuing_order_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_order_form
                    visible: false
                }

            },

            State {

                name: "prepearing_orders_list_state"

                PropertyChanges {
                    target: issuing_orders_list_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_orders_list_form
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

                PropertyChanges {
                    target: issuing_order_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_order_form
                    visible: false
                }

            },

            State {

                name: "order_prepearing_state"

                PropertyChanges {
                    target: issuing_orders_list_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_orders_list_form
                    visible: false
                }

                PropertyChanges {
                    target: order_issuing_text
                    visible: false
                }

                PropertyChanges {
                    target: order_prepearing_text
                    visible: false
                }

                PropertyChanges {
                    target: issuing_order_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_order_form
                    visible: true
                }

            },

            State {

                name: "order_issuing_state"

                PropertyChanges {
                    target: issuing_orders_list_form
                    visible: false
                }

                PropertyChanges {
                    target: prepearing_orders_list_form
                    visible: false
                }

                PropertyChanges {
                    target: order_issuing_text
                    visible: false
                }

                PropertyChanges {
                    target: order_prepearing_text
                    visible: false
                }

                PropertyChanges {
                    target: issuing_order_form
                    visible: true
                }

                PropertyChanges {
                    target: prepearing_order_form
                    visible: false
                }

            }

        ]


        IssuingOrdersListForm {
            id: issuing_orders_list_form
        }

        PrepearingOrdersListForm {
            id: prepearing_orders_list_form
            visible: false
        }

        IssuingOrdersListModel {
            id: issuing_orders_list_model
        }

        IssuingOrdersListCopyModel {
            id: issuing_orders_list_model_copy
        }

        PrepearingOrdersListModel {
            id: prepearing_orders_list_model
        }

        IssuingOrderForm {
            id: issuing_order_form
            visible: false
        }

        PrepearingOrderForm {
            id: prepearing_order_form
            visible: false
        }

        IssuingOrderModel {
            id: issuing_order_model
        }

        PrepearingOrderModel {
            id: prepearing_order_model
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

            layer.enabled: order_prepearing_mouse_area.containsMouse
            layer.effect: MultiEffect {

                id: order_prepearing_text_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

            MouseArea {

                id: order_prepearing_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    workspace_rectangle.state = "prepearing_orders_list_state";

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

            layer.enabled: order_issuing_mouse_area.containsMouse
            layer.effect: MultiEffect {

                id: order_issuing_text_shadow
                blurEnabled: true
                blurMax: 12
                blur: 0.6
                saturation: 0.4
                contrast: 0.2

            }

            MouseArea {

                id: order_issuing_mouse_area
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {

                    workspace_rectangle.state = "issuing_orders_list_state";

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

    Connections {

        target: Client
        function onAddOrderToOrederIssuingModel(order_id, ordered_timestamp, receive_code, phone_number, total_cost, order_data) {

            var order_array = {"order_data" : []};

            for (var i = 0; i < order_data.length; ++i) {

                order_array.order_data.push(order_data[i]);

            }

            issuing_orders_list_model.append({ order_id: order_id, ordered_timestamp: ordered_timestamp, receive_code: receive_code,
                                               phone_number: phone_number, total_cost: total_cost, order_data: order_array });

            issuing_orders_list_model_copy.append({ order_id: order_id, ordered_timestamp: ordered_timestamp, receive_code: receive_code,
                                               phone_number: phone_number, total_cost: total_cost, order_data: order_array });

            if (issuing_orders_list_model_copy.code_mask.length !== 0 || issuing_orders_list_model_copy.phone_mask.length !== 0) {

                issuing_orders_list_form.updateCopyModel();

            }

            console.log(order_id + " to issuing model");

        }

    }

    Connections {

        target: Client
        function onAddOrderToOrderPrepearingModel(order_id, phone_number, receive_code, ordered_timestamp, total_cost, order_data) {

            var order_array = {"order_data" : []};

            for (var i = 0; i < order_data.length; ++i) {

                order_array.order_data.push(order_data[i]);

            }

            prepearing_orders_list_model.append({ order_id: order_id, phone_number: phone_number, receive_code: receive_code,
                                                  ordered_timestamp: ordered_timestamp, total_cost: total_cost, order_data: order_array });

            console.log(order_id + " to prepearing model");

        }

    }

    Connections {

        target: Client
        function onStartIssuingOrderConfirmed(order_id) {

            console.log("start issuing inside qml " + order_id);

            for (var i = 0; i < issuing_orders_list_model.count; ++i) {

                console.log(issuing_orders_list_model.get(i).order_id);

                if (issuing_orders_list_model.get(i).order_id === order_id) {

                    console.log("found order_id");

                    issuing_order_model.clear();

                    for (var j = 0; j < issuing_orders_list_model.get(i).order_data.order_data.length; ++j) {

                        var image_directory;

                        if (issuing_orders_list_model.get(i).order_data.order_data[j].type === "Sauce") {

                            image_directory = "Sauces";

                        } else if (issuing_orders_list_model.get(i).order_data.order_data[j].type === "Seasoning") {

                            image_directory = "Seasonings";

                        } else if (issuing_orders_list_model.get(i).order_data.order_data[j].type === "Seeds") {

                            image_directory = "Seeds";

                        }

                        issuing_order_model.append({ product_id: issuing_orders_list_model.get(i).order_data.order_data[j].id,
                                                     name: issuing_orders_list_model.get(i).order_data.order_data[j].name,
                                                     description: issuing_orders_list_model.get(i).order_data.order_data[j].description,
                                                     price: issuing_orders_list_model.get(i).order_data.order_data[j].price,
                                                     number_of_items: issuing_orders_list_model.get(i).order_data.order_data[j].number_of_items,
                                                     image: "file://" + applicationDirPath + "/../Images/Catalog/" + image_directory + "/" +
                                                            issuing_orders_list_model.get(i).order_data.order_data[j].id + ".png"
                                                   });

                    }

                    issuing_order_model.order_id = issuing_orders_list_model.get(i).order_id;
                    issuing_order_model.phone_number = issuing_orders_list_model.get(i).phone_number;
                    issuing_order_model.receive_code = issuing_orders_list_model.get(i).receive_code;
                    issuing_order_model.ordered_timestamp = issuing_orders_list_model.get(i).ordered_timestamp;
                    issuing_order_model.total_cost = issuing_orders_list_model.get(i).total_cost;

                    workspace_rectangle.state = "order_issuing_state";

                    break;

                }

            }

        }

    }

    Connections {

        target: Client
        function onStartPrepearingOrderConfirmed(order_id) {

            console.log("start prepearing inside qml " + order_id);

            for (var i = 0; i < prepearing_orders_list_model.count; ++i) {

                console.log(prepearing_orders_list_model.get(i).order_id);

                if (prepearing_orders_list_model.get(i).order_id === order_id) {

                    console.log("found order_id");

                    prepearing_order_model.clear();

                    for (var j = 0; j < prepearing_orders_list_model.get(i).order_data.order_data.length; ++j) {

                        var image_directory;

                        if (prepearing_orders_list_model.get(i).order_data.order_data[j].type === "Sauce") {

                            image_directory = "Sauces";

                        } else if (prepearing_orders_list_model.get(i).order_data.order_data[j].type === "Seasoning") {

                            image_directory = "Seasonings";

                        } else if (prepearing_orders_list_model.get(i).order_data.order_data[j].type === "Seeds") {

                            image_directory = "Seeds";

                        }

                        prepearing_order_model.append({ product_id: prepearing_orders_list_model.get(i).order_data.order_data[j].id,
                                                        name: prepearing_orders_list_model.get(i).order_data.order_data[j].name,
                                                        description: prepearing_orders_list_model.get(i).order_data.order_data[j].description,
                                                        price: prepearing_orders_list_model.get(i).order_data.order_data[j].price,
                                                        number_of_items: prepearing_orders_list_model.get(i).order_data.order_data[j].number_of_items,
                                                        image: "file://" + applicationDirPath + "/../Images/Catalog/" + image_directory + "/" +
                                                               prepearing_orders_list_model.get(i).order_data.order_data[j].id + ".png",
                                                        prepeared: false });

                        console.log(prepearing_orders_list_model.get(i).order_data.order_data[j].id + " id to prepearing model");

                    }

                    prepearing_order_model.order_id = prepearing_orders_list_model.get(i).order_id;
                    prepearing_order_model.receive_code = prepearing_orders_list_model.get(i).receive_code;
                    prepearing_order_model.phone_number = prepearing_orders_list_model.get(i).phone_number;
                    prepearing_order_model.ordered_timestamp = prepearing_orders_list_model.get(i).ordered_timestamp;
                    prepearing_order_model.total_cost = prepearing_orders_list_model.get(i).total_cost;

                    workspace_rectangle.state = "order_prepearing_state";

                    break;

                }

            }

        }

    }

    Connections {

        target: prepearing_order_form
        function onPrepeareOrderError() {

            showMessage("Ошибка подготовки заказа","Добавьте все необходимые\nтовары в заказ!");

        }
    }


    Connections {

        target: Client
        function onStopPrepearingOrderConfirmed(order_id) {

            workspace_rectangle.state = "prepearing_orders_list_state";

        }

    }

    Connections {

        target: Client
        function onStopIssuingOrderConfirmed(order_id) {

            workspace_rectangle.state = "issuing_orders_list_state";

        }

    }

    Connections {

        target: Client
        function onRemoveOrder(order_id) {

            if (issuing_order_model.order_id === order_id) {

                Client.onStopIssuingOrder(order_id);
                issuing_order_model.clear();
                showMessage("Отмена заказа", "Пользователь отменил данный заказ!");
                workspace_rectangle.state = "issuing_orders_list_state";

            } else if (prepearing_order_model.order_id === order_id) {

                Client.onStopPrepearingOrder(order_id);
                prepearing_order_model.clear();
                showMessage("Отмена заказа", "Пользователь отменил данный заказ!");
                workspace_rectangle.state = "prepearing_orders_list_state";

            }

            for (var i = 0; i < issuing_orders_list_model.count; ++i) {

                if (issuing_orders_list_model.get(i).order_id === order_id) {

                    issuing_orders_list_model.remove(i);
                    return;

                }

                if (issuing_orders_list_model_copy.get(i).order_id === order_id) {

                    issuing_orders_list_model.remove(i);
                    return;

                }


            }

            for (var j = 0; j < prepearing_orders_list_model.count; ++j) {

                if (prepearing_orders_list_model.get(j).order_id === order_id) {

                    prepearing_orders_list_model.remove(j);
                    return;

                }

            }

        }

    }

    Connections {

        target: Client
        function onOrderReceivedConfirmed(order_id, phone_number, receive_code) {

            if (issuing_order_model.order_id === order_id &&
                issuing_order_model.phone_number === phone_number &&
                issuing_order_model.receive_code === receive_code) {

                issuing_order_model.clear();

                for (var i = 0; i < issuing_orders_list_model.count; ++i) {

                    if (issuing_orders_list_model.get(i).order_id === order_id) {

                        issuing_orders_list_model.remove(i);

                    }

                }

                for (var j = 0; j < issuing_orders_list_model_copy.count; ++j) {

                    if (issuing_orders_list_model_copy.get(j).order_id === order_id) {

                        issuing_orders_list_model_copy.remove(j);

                    }

                }

                workspace_rectangle.state = "issuing_orders_list_state";

            }

        }

    }


    Connections {

        target: Client
        function onOrderPrepearedConfirmed(order_id) {

            for (var i = 0; i < prepearing_orders_list_model.count; ++i) {

                if (prepearing_orders_list_model.get(i).order_id === order_id) {

                    var order_array = {"order_data" : []};

                    for (var j = 0; j < prepearing_orders_list_model.get(i).order_data.order_data.length; ++j) {

                        order_array.order_data.push(prepearing_orders_list_model.get(i).order_data.order_data[j]);

                    }

                    issuing_orders_list_model.append({ order_id: prepearing_orders_list_model.get(i).order_id,
                                                       ordered_timestamp: prepearing_orders_list_model.get(i).ordered_timestamp,
                                                       receive_code: prepearing_orders_list_model.get(i).receive_code,
                                                       phone_number: prepearing_orders_list_model.get(i).phone_number,
                                                       total_cost: prepearing_orders_list_model.get(i).total_cost,
                                                       order_data: order_array });

                    prepearing_orders_list_model.remove(i);
                    prepearing_order_model.clear();
                    issuing_orders_list_form.updateCopyModel();

                    workspace_rectangle.state = "prepearing_orders_list_state";

                }

            }

        }

    }

    Connections {

        target: Client
        function onSetOrderPrepeared(order_id) {

            for (var i = 0; i < prepearing_orders_list_model.count; ++i) {

                if (prepearing_orders_list_model.get(i).order_id === order_id) {

                    var order_array = {"order_data" : []};

                    for (var j = 0; j < prepearing_orders_list_model.get(i).order_data.order_data.length; ++j) {

                        order_array.order_data.push(prepearing_orders_list_model.get(i).order_data.order_data[j]);

                    }

                    issuing_orders_list_model.append({ order_id: prepearing_orders_list_model.get(i).order_id,
                                                       ordered_timestamp: prepearing_orders_list_model.get(i).ordered_timestamp,
                                                       receive_code: prepearing_orders_list_model.get(i).receive_code,
                                                       phone_number: prepearing_orders_list_model.get(i).phone_number,
                                                       total_cost: prepearing_orders_list_model.get(i).total_cost,
                                                       order_data: order_array });

                    prepearing_orders_list_model.remove(i);

                    issuing_orders_list_form.updateCopyModel();

                }

            }

        }

    }

    Connections {

        target: Client
        function onSetOrderReceived(order_id) {

            for (var i = 0; i < issuing_orders_list_model.count; ++i) {

                if (issuing_orders_list_model.get(i).order_id === order_id) {

                    issuing_orders_list_model.remove(i);

                }

            }

            for (var j = 0; j < issuing_orders_list_model_copy.count; ++j) {

                if (issuing_orders_list_model_copy.get(j).order_id === order_id) {

                    issuing_orders_list_model_copy.remove(j);

                }

            }


        }

    }

}
