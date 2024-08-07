$(document).ready(function () {

    var infoMessage = $("#info_message");


    //Add product to the cart

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
        var current_url = $(this).data("current-url");

        console.log(current_url);
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

                var orderConfirmationWrapper = $("#order_confirmation_wrapper");
                orderConfirmationWrapper.html(data.cart_items_html);
                

                if (data.redirect) {

                    window.location = "/";

                }

            },

            error: function (data) {
                console.log("Ошибка при удалении корзины");
            }
            
        });

    });

    $(document).on("click", ".cart_increment_button", function (e) {
    
        e.preventDefault();

        var cart_id = $(this).data("cart-id");
        var url = $(this).data("cart-change-url");


        var quantity = parseInt($(this).prev().text());

        console.log("increment ", cart_id, quantity);

        updateCart(cart_id, quantity + 1, 1, url);

    });

    $(document).on("click", ".cart_decrement_button", function (e) {
    
        e.preventDefault();

        var cart_id = $(this).data("cart-id");
        var url = $(this).data("cart-change-url");


        var quantity = parseInt($(this).next().text());
        console.log("decrement ", cart_id, quantity);

        updateCart(cart_id, quantity - 1, -1, url);

    });

    function updateCart(cart_id, quantity, change, url) {

        $.ajax({
            type: "POST",
            url: url,
            data: {
                cart_id: cart_id,
                quantity: quantity,
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {

                console.log("Success!");
                console.log("update ", cart_id, quantity, change);

                var goodsInCartCount = $("#cart_quantity_value");
                
                var cartCount = parseInt(goodsInCartCount.text() || 0);
                cartCount += change;
                goodsInCartCount.text(cartCount);
                

                var cartItemsContainer = $("#cart-items-container");
                cartItemsContainer.html(data.cart_items_html);
                
                var orderConfirmationWrapper = $("#order_confirmation_wrapper");
                orderConfirmationWrapper.html(data.cart_items_html);

                if (data.redirect) {

                    window.location.href = "/";

                }

            },
            error: function (data) {
                console.log("Ошибка при обновлении корзины");
            },
        });
        
    }


    /*
    $(document).on("click", "#order_confirmation_navigation", function (e) {

        e.preventDefault();

        console.log("Order confirmation clicked!");

        var url = $(this).attr("href");

        console.log(url);

        $.ajax({
            
            type: "GET",
            url: url,
            data: {
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {

                var cartItemsContainer = $(".profile_main_wrapper");
                cartItemsContainer.html(data.cart_items_html);

                //window.history.pushState(null, null, "order_confirmation/")

                console.log("Success confirmation");

            }
            
        });

    });

    $(document).on("click", "#deliveries_navigation", function (e) {

        e.preventDefault();

        console.log("Deliveries clicked!");

        var url = $(this).attr("href");

        console.log(url);

        $.ajax({
            
            type: "GET",
            url: url,
            data: {
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {

                var profileWrapper = $(".profile_main_wrapper");
                profileWrapper.html(data.deliveries_html);

                console.log("Success deliveries");

            }
            
        });

    });

    $(document).on("click", "#received_orders_navigation", function (e) {

        e.preventDefault();

        console.log("Received orders clicked!");

        var url = $(this).attr("href");

        console.log(url);

        $.ajax({
            
            type: "GET",
            url: url,
            data: {
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {

                var profileWrapper = $(".profile_main_wrapper");
                profileWrapper.html(data.received_orders_html);

                console.log("Success received orders!");

            }
            
        });

    });
    
    */

    $('input[name="requires_delivery"]').change(function () {

        console.log("Requires delivery changed!");

        var selectedValue = $(this).val();

        console.log(selectedValue);

        
        if (selectedValue === "1") {
            $("#id_delivery_address").show();
            $("#delivery_address_label").show();
        } else {
            $("#id_delivery_address").hide();
            $("#delivery_address_label").hide();
        }
    });

    
    document.getElementById('id_phone_number').addEventListener('input', function (e) {
        var x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
        e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
    });

    
    $('#create_order_form').on('submit', function (event) {
        var phoneNumber = $('#id_phone_number').val();
        var regex = /^\(\d{3}\) \d{3}-\d{4}$/;

        if (!regex.test(phoneNumber)) {
            $('#phone_number_error').show();
            event.preventDefault();
        } else {
            $('#phone_number_error').hide();

           
            var cleanedPhoneNumber = phoneNumber.replace(/[()\-\s]/g, '');
            $('#id_phone_number').val(cleanedPhoneNumber);
        }
    });


});