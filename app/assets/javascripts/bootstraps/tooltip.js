$(document).on("turbolinks:load", function() {
    $(function () {
        $('[data-toggle=tooltip').tooltip();
    });
    $(function () {
        return $(".tooltip-show").click(function (e) {
            return $('#mybutton').tooltip('show');
        })
    });

    $(function () {
        return $(".tooltip-hide").click(function (e) {
            return $('#mybutton').tooltip('hide');
        })
    });
    $(function () {
        $('[data-toggle=popover').popover();
    });
});