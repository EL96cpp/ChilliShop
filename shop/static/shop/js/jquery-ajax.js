$(document).ready(function () {


    $(document).on("click", ".card_button", function(e) {

        e.preventDefault();

        var product_id = $(this).data("product-id");
        var add_to_cart_url = $(this).attr("href");

        $.ajax({
            
            type: "POST",
            url: add_to_cart_url,
            data: {
                product_id: product_id,
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {
                var cartItemsContainer = $("#cart-items-container");
                cartItemsContainer.html(data.cart_items_html);
            }
            
        });
        

    });

    $(document).on("click", ".remove_from_cart", function (e) {

        console.log("Click remove!");

        e.preventDefault();

        var goods_in_cart_count = $("#cart_total_quantity");
        var cart_count = parseInt(goods_in_cart_count.text() || 0);

        var cart_id = $(this).data("cart-id");
        var remove_url = $(this).attr("href");

        console.log(cart_id, remove_url);
        console.log(cart_count);

        $.ajax({
            
            type: "POST",
            url: remove_url,
            data: {
                cart_id: cart_id,
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {
                var cartItemsContainer = $("#cart-items-container");
                cartItemsContainer.html(data.cart_items_html);

                cart_count -= data.quantity_deleted;
                goods_in_cart_count.text(cart_count);

                var cart_items_container = $("#cart-items-container");
                cart_items_container.html(data.cart_items_html);

            }
            
        });

    });


});