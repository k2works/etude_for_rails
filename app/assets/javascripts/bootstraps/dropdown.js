$(document).on("turbolinks:load", function() {
    $('.link-show-dropdown').on('mouseover', function(e) {
        $('#mylabel').dropdown('toggle');
    });

    var menus = ['メニュー1','メニュー2','メニュー3'];
    var menu_selected = {};

    $(function () {
        // ドロップダウンリストが開かれようとするときのイベント
        $('#mydropdown2').on('show.bs.dropdown', function (e) {
            var icon;
            var ul = $('#menulist');
            ul.empty();
            // メニューを動的に作成する
            $.each(menus, function(i) {
                icon = "";
                if (menu_selected[i]) {
                    icon = "<span class='glyphicon glyphicon-ok'></span>";
                }
                ul.append("<li role='presentation'>" +
                    "<a href='#' data-index='" + i +
                    "' tabindex='-1'>" + icon + this + "</a></li>");
            });
        });

        // メニュー項目がクリックされた時のイベント
        $('#menulist').on('click', function (e) {
            e.preventDefault();
            var index = $(e.target).attr('data-index');
            if(index !== undefined) {
                menu_selected[index] = menu_selected[index] ? false : true;
            }
        });
    });
});