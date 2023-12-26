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

    // Use goods_model_copy to filter and delete it's elements
    property ListModel goods_model: sauces_model
    property ListModel goods_model_copy: copy_model

    property var pepper_filters: []
    property int lower_price_limit: 0
    property int upper_price_limit: -1
    property string order_by: "none"

    signal addToCartSignal(var id, var name, var json_description, var price, var image);

    function setModelCopy() {

        if (goods_model_copy.count !== 0) {

            goods_model_copy.clear();

        }

        for (var i = 0; i < goods_model.count; ++i) {

            goods_model_copy.append(goods_model.get(i));

        }

    }

    function filterByPeppers() {

        // Pepper filters
        if (pepper_filters.length != 0) {

            var filtered_goods_counter = 0;

            for (var j = 0; j < goods_model_copy.count; ++j) {

                var should_be_visible = true;

                for (var i = 0; i < pepper_filters.length; ++i) {


                    if (goods_model_copy.get(j).peppers.array.indexOf(pepper_filters[i]) === -1) {

                        should_be_visible = false;
                        break;

                    }



                }

                if (should_be_visible) {

                    goods_model_copy.move(j, filtered_goods_counter, 1);
                    ++filtered_goods_counter;

                }


            }

            if (filtered_goods_counter === 0) {

                goods_model_copy.clear();

            } else if (filtered_goods_counter !== goods_model_copy.count) {

                goods_model_copy.remove(filtered_goods_counter, goods_model_copy.count - filtered_goods_counter);

            }

        }

    }

    function filterByLowerPriceLimit() {

        if (lower_price_limit !== 0) {

            var lower_limit_goods_counter = 0;

            for (var j = 0; j < goods_model_copy.count; ++j) {

                var should_be_visible = true;

                if (goods_model_copy.get(j).price < lower_price_limit) {

                    should_be_visible = false;

                }

                if (should_be_visible) {

                    goods_model_copy.move(j, lower_limit_goods_counter, 1);
                    ++lower_limit_goods_counter;

                }

            }

            if (lower_limit_goods_counter === 0) {

                goods_model_copy.clear();

            } else if (lower_limit_goods_counter !== goods_model_copy.count) {

                goods_model_copy.remove(lower_limit_goods_counter, goods_model_copy.count - lower_limit_goods_counter);

            }

        }

    }

    function filterByUpperPriceLimit() {

        if (upper_price_limit !== -1) {

            var upper_limit_goods_counter = 0;

            for (var j = 0; j < goods_model_copy.count; ++j) {

                var should_be_visible = true;

                if (goods_model_copy.get(j).price > upper_price_limit) {

                    should_be_visible = false;

                }

                if (should_be_visible) {

                    goods_model_copy.move(j, upper_limit_goods_counter, 1);
                    ++upper_limit_goods_counter;

                }

            }

            if (upper_limit_goods_counter === 0) {

                goods_model_copy.clear();

            } else if (upper_limit_goods_counter !== goods_model_copy.count) {

                goods_model_copy.remove(upper_limit_goods_counter, goods_model_copy.count - upper_limit_goods_counter);

            }

        }
    }


    function filterModel() {

        // Sort by pepper and price limits
        filterByPeppers();
        filterByLowerPriceLimit();
        filterByUpperPriceLimit();

        // Sort filters
        if (order_by == "price_decrease") {

            goods_model_copy.sortByPriceDecrease();

        } else if (order_by == "price_increase") {

            goods_model_copy.sortByPriceIncrease();

        } else if (order_by == "scoville_decrease") {

            goods_model_copy.sortByScovilleDecrease();

        } else if (order_by == "scoville_increase") {

            goods_model_copy.sortByScovilleIncrease();

        }

    }

    GridView {

        id: goods_grid
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        cellWidth: 410
        cellHeight: 580

        model: grid_rectangle.goods_model_copy

        clip: true

        delegate: GoodDelegate {

            id: good_delegate_rectange

        }

    }

    Connections {

        target: filters_column_rect

        function onRemoveFiltersSignal() {

            pepper_filters = [];
            upper_price_limit = 0;
            upper_price_limit = -1;

            setModelCopy();
            goods_grid.model = goods_model_copy;

        }

    }

    Connections {

        target: filters_column_rect

        function onPepperFilterChangedSignal(pepper_name, filter_is_active) {

            if (filter_is_active) {

                pepper_filters.push(pepper_name);
                filterModel();

            } else {

                pepper_filters.splice(pepper_filters.indexOf(pepper_name), 1);
                setModelCopy();
                filterModel();

            }

        }

    }

    Connections {

        target: filters_column_rect

        function onSortFilterChangedSignal(sort_filter_type) {

            order_by = sort_filter_type;
            filterModel();

        }

    }

    Connections {

        target: filters_column_rect

        function onSetLowerPriceFilterSignal(lower_price) {

            grid_rectangle.lower_price_limit = lower_price;
            setModelCopy();
            filterModel();

        }


    }

    Connections {

        target: filters_column_rect

        function onSetUpperPriceFilterSignal(upper_price) {

            grid_rectangle.upper_price_limit = upper_price;
            setModelCopy();
            filterModel();

        }

    }

    Connections {

        target: header_rect

        function onSetSaucesModelSignal() {

            grid_rectangle.goods_model = sauces_model;
            setModelCopy();
            filterModel();

        }

    }

    Connections {

        target: header_rect

        function onSetSeedsModelSignal() {

            grid_rectangle.goods_model = seeds_model;
            setModelCopy();
            filterModel();

        }

    }

    Connections {

        target: header_rect

        function onSetSeasoningsModelSignal() {

            grid_rectangle.goods_model = seasonings_model;
            setModelCopy();
            filterModel();

        }

    }


}
