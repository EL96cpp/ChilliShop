$(document).ready(function () {


    $(document).on("click", ".card_button", function(e) {

        console.log("Click!");

        e.preventDefault();

        var product_id = $(this).data("product-id");
        var add_to_cart_url = $(this).attr("href");

        console.log(product_id, add_to_cart_url);


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


});