$(document).on("turbolinks:load", function() {
    $(function () {
        $('.btn_tab1').on('click', function (e) {
            $('#mytab a:first').tab('show');
        })
    });
    $(function () {
        $('.btn_tab2').on('click', function (e) {
            $('#mytab li:eq(1) a').tab('show');
        })
    });
    $(function () {
        $('.btn_tab3').on('click', function (e) {
            $('#mytab a:last').tab('show');
        })
    });

    $('#mytab2').on('show.bs.tab', function (e) {
        var fromTab = e.relatedTarget;
        var toTab = e.target;

        if(!confirm(
                fromTab.innerHTML + 'から' + toTab.innerHTML +
                'に切り替えます。よろしいですか?'))
        {
            e.preventDefault();
        }
    });
});