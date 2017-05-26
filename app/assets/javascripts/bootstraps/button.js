$(document).on("turbolinks:load", function() {
    $(function () {
        $('#mybutton2').on('click', function (e) {
            var btn = $(this);
            btn.button('loading');
            // 話を簡単にするため2000ミリ秒後に実行するが、
            // 実際は、Ajaxの処理が終わった時などに呼び出すことになる
            setTimeout(function () {
                btn.button('reset');
            }, 2000);
        });
    });
});
