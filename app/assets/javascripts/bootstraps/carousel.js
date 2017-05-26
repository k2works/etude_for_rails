$(document).on("turbolinks:load", function() {
    $(function () {
        $('.mycarousel_left').on('click', function (e) {
            $('#mycarousel').carousel(1);
        });
    });

    $(function () {
        $('#mycarousel2').on('slide.bs.carousel', function (e) {
            if(!confirm('切り替えても、よろしいですか?')) {
                $('#mycarousel2').carousel('pause');
                e.preventDefault();
            }
        });
    });
});