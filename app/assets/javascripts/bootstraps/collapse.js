$(document).on("turbolinks:load", function() {
    $(function () {
        $('.btn_collapse_show').on('click', function (e) {
            $('#closepanel').collapse('show');
        })
    });

    $(function () {
        $('.btn_collapse_hide').on('click', function (e) {
            $('#closepanel').collapse('hide');
        })
    });

    $(function () {
        $('#closepanel2').on('hide.bs.collapse', function(e) {
            if(!confirm('閉じてよろしいですか?')) {
                e.preventDefault();
            }
        });
    })
});