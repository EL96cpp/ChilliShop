$(document).ready(function () {

    var infoMessage = $("#info_message");

    //Filter functions
    $(document).on("click", "#sales_filters", function(e) {

        filterProducts();

    });

    $('input[name="order_by"]').on("click", function(e) {

        filterProducts();

    });

    $('#lower_price_limit').on("input", function(e) {

        filterProducts();

    });

    $('#upper_price_limit').on("input", function(e) {

        filterProducts();

    });


    function filterProducts() {

        var sales_only = $("#sales_filters").is(":checked");

        console.log("Filters sales clicked! ", sales_only);

        var order_by_text = $('input[name="order_by"]:checked').val();
        var lower_price_text = $("#lower_price_limit").val();
        var upper_price_text = $("#upper_price_limit").val();

        console.log(order_by_text, lower_price_text, upper_price_text);

        $.ajax({
            
            type: "GET",
            url: 'filter_products',
            data: {
                sales_only: sales_only,
                order_by: order_by_text,
                lower_price_limit: lower_price_text,
                upper_price_limit: upper_price_text,
                csrfmiddlewaretoken: $("[name=csrfmiddlewaretoken]").val(),
            },

            success: function (data) {
                console.log("Filtered successfully!");
                
                var productsContainer = $("#products_container");
                productsContainer.html(data.products_html);                

            },

            error: function (data) {
                console.log("Ошибка при удалении корзины");
            }
            
        });


    }

    //Clear prduct filters
    $(document).on("click", "#clear_filters_btn", function(e) {

        e.preventDefault();

        $("#sales_filters").prop("checked", false);;

        $('input[name="order_by"]:checked').prop('checked', false);
        $("#lower_price_limit").val('');
        $("#upper_price_limit").val('');

        filterProducts();

    });


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
                

                if (data.redirect && window.location.href=="/users/profile/order_confirmation") {

                    console.log("Redirect!");
                    window.location.href = "/users/profile/deliveries";

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

                if (data.redirect && window.location.href=="/users/profile/order_confirmation") {

                    console.log(window.location.href);
                    console.log("Redirect!");
                    window.location.href = "/users/profile/deliveries";

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

    // Обработчик события радиокнопки выбора способа доставки
    $('input[name="requires_delivery"]').change(function () {

        console.log("Requires delivery changed!");

        var selectedValue = $(this).val();

        console.log(selectedValue);

        // Скрываем или отображаем input ввода адреса доставки
        if (selectedValue === "1") {
            $("#id_delivery_address").show();
            $("#delivery_address_label").show();
        } else {
            $("#id_delivery_address").hide();
            $("#delivery_address_label").hide();
        }
    });

    // Форматирования ввода номера телефона в форме (xxx) xxx-хххx
    document.getElementById('id_phone_number').addEventListener('input', function (e) {
        var x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
        e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
    });

    // Проверяем на стороне клинта коррекность номера телефона в форме xxx-xxx-хх-хx
    $('#create_order_form').on('submit', function (event) {
        var phoneNumber = $('#id_phone_number').val();
        var regex = /^\(\d{3}\) \d{3}-\d{4}$/;

        if (!regex.test(phoneNumber)) {
            $('#phone_number_error').show();
            event.preventDefault();
        } else {
            $('#phone_number_error').hide();

            // Очистка номера телефона от скобок и тире перед отправкой формы
            var cleanedPhoneNumber = phoneNumber.replace(/[()\-\s]/g, '');
            $('#id_phone_number').val(cleanedPhoneNumber);
        }
    });


});