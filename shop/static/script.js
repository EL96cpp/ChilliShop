console.log("Hello, world!");


function addPepperFilter(pepper_name) {


}

function pepperFilterClicked(pepper_name) {

    console.log(pepper_name);

}

function clearFilters() {

    console.log($("card_image").attr('src'))

    console.log("Clear filters");
    console.log($(".filters_checkbox").is(':checked'));
    console.log($(".filters_element").each(".filters_checkbox").is(":checked"));

}