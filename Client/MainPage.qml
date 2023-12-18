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

        function onToMenu() {

            stack_view.pop(main_page);

        }

    }

    Connections {

        target: Client

        function onAddSauceProductToModel(id, name, price, scoville, text_description, volume, peppers) {


            var peppers_json_array = {"array" : []};

            for (var i = 0; i < peppers.length; ++i) {

                peppers_json_array.array.push(peppers[i]);
                console.log(peppers[i]);

            }

            sauces_model.append( {id: id, name: name, price: price/100, scoville: scoville, text_description: text_description, volume: volume,
                                  image: "file://" + applicationDirPath + "/../Images/Catalog/Sauces/" + id + ".png", peppers: peppers_json_array} );

            copy_model.append( {id: id, name: name, price: price/100, scoville: scoville, text_description: text_description, volume: volume,
                                  image: "file://" + applicationDirPath + "/../Images/Catalog/Sauces/" + id + ".png", peppers: peppers_json_array} );


            sauces_model.showPeppers();

        }

    }

    Connections {

        target: Client

        function onAddSeasoningProductToModel(id, name, price, scoville, text_description, weight_gramms, peppers) {

            var peppers_json_array = {"array" : []};

            for (var i = 0; i < peppers.length; ++i) {

                peppers_json_array.array.push(peppers[i]);
                console.log(peppers[i]);

            }

            seasonings_model.append( {id: id, name: name, price: price/100, scoville: scoville, text_description: text_description, weight_gramms: weight_gramms,
                                  image: "file://" + applicationDirPath + "/../Images/Catalog/Seasonings/" + id + ".png", peppers: peppers_json_array} );

        }

    }

    Connections {

        target: Client

        function onAddSeedsProductToModel(id, name, price, scoville, text_description, number_of_seeds, peppers) {

            var peppers_json_array = {"array" : []};

            for (var i = 0; i < peppers.length; ++i) {

                peppers_json_array.array.push(peppers[i]);
                console.log(peppers[i]);

            }

            seeds_model.append( {id: id, name: name, price: price/100, scoville: scoville, text_description: text_description, number_of_seeds: number_of_seeds,
                                  image: "file://" + applicationDirPath + "/../Images/Catalog/Seeds/" + id + ".png", peppers: peppers_json_array} );

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

    SaucesModel {

        id: copy_model

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

        anchors.top: header_image.bottom
        anchors.topMargin: filters_column_rect.anchors.margins
        anchors.horizontalCenter: parent.horizontalCenter

        signal setSaucesModelSignal();
        signal setSeedsModelSignal();
        signal setSeasoningsModelSignal();

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

                    header_rect.setSaucesModelSignal();

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

                    header_rect.setSeasoningsModelSignal();

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

                    header_rect.setSeedsModelSignal();

                }

            }

        }


    }


    Filters {
        id: filters_column_rect
    }

    GoodsGrid {
        id: grid_rectangle
    }

    CartView {
        id: cart_rectangle
    }

    Text {

        id: clear_cart_text
        text: "Очистить корзину"
        color: clear_cart_mouse_area.containsMouse ? hover_color : "#E2E2E2"
        font.family: regular_font.name
        font.pointSize: 12
        font.wordSpacing: 5
        font.bold: true

        anchors.horizontalCenter: cart_rectangle.horizontalCenter
        anchors.top: cart_rectangle.bottom
        anchors.topMargin: 10

        signal clearCartModel();

        MouseArea {

            id: clear_cart_mouse_area
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {

                clear_cart_text.clearCartModel();

            }

        }

    }


}
