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

    property ListModel goods_model: sauces_model

    property var pepper_filters: []
    property int lower_price_limit: 0
    property int upper_price_limit: -1
    property string order_by: "none"


    function filterModel() {

        if (order_by == "price_decrease") {

            goods_model.sortByPriceDecrease();

        } else if (order_by == "price_increase") {

            goods_model.sortByPriceIncrease();

        } else if (order_by == "scoville_decrease") {



        } else if (order_by == "scoville_increase") {



        }

        for (var i = 0; i < goods_model.count; ++i) {

            console.log(goods_model.get(i).price);

        }

    }

    GridView {

        id: goods_grid
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        cellWidth: 410
        cellHeight: 580

        clip: true

        model: grid_rectangle.goods_model

        delegate: GoodDelegate {

            id: good_delegate_rectange

        }


    }

    Connections {

        target: filters_column_rect

        function onRemoveFiltersSignal() {

            console.log("remove filters in grid");
            pepper_filters = [];
            lower_price_limit = 0;
            upper_price_limit = -1;

            for (var i = 0; i < goods_model.count; ++i) {

                goods_model.get(i).visible = true;
                console.log(i);

            }

        }

    }

    Connections {

        target: filters_column_rect

        function onPepperFilterChangedSignal(pepper_name, filter_is_active) {

            console.log("grid get pepper signal");

            if (filter_is_active) {

                console.log("added filter " + pepper_name);
                filterModel();

            } else {

                console.log("remove filter " + pepper_name);
                filterModel();

            }

        }

    }

    Connections {

        target: filters_column_rect

        function onSortFilterChangedSignal(sort_filter_type) {

            order_by = sort_filter_type;
            console.log("sort filter type set " + sort_filter_type);
            filterModel();

        }

    }


}
