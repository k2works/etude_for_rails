$(document).on("turbolinks:load", function() {
    (function(){
        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton3").click(function () {
                // 文字列を取得
                var text = $("#userText3").val();

                // 文字列の長さを出力
                $("#output3").text("文字列の長さは" + text.length + "です。");
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton3-2").click(function () {
                // 文字列を取得
                var text = $("#userText3-2").val();

                // 文字列の長話を計算
                var len = 0;
                for(var i = 0; i < text.length; i ++) {
                    var c = text.charCodeAt(i);
                    if ((c >= 0x0 && c < 0x81) || (c == 0xf8f0)
                        || (c >= 0xff61 && c < 0xffa0)
                        || (c >= 0xf8f1 && c < 0xf8f4)) {
                        len ++;
                    } else {
                        len += 2;
                    }
                }

                // 文字列の長さを出力
                $("#output3-2").text("文字列の長さは「" + len + "」です。");
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton4").click(function () {
                // 文字列を取得
                var text = $("#userText4").val();

                // タグの除去
                text = text.replace(/<.+?>/g, "");

                // 文字列を表示
                $("#output4").val(text);
            });
        });

        $(function () {
            // [エンコード]ボタンを押した時の処理を設定
            $("#encodeButton").click(function () {
                // 文字列を取得
                var text = $("#userText5").val();

                // エンコード
                text = encodeURI(text);

                // 文字列を表示
                $("#output5").val(text);
            });

            // [デコード]ボタンを押した時の処理を設定
            $("#decodeButton").click(function () {
                // 文字列を取得
                var text = $("#userText5").val()

                // デコード
                try {
                    text = decodeURI(text);
                } catch(e) {
                    console.log("error : " + e);
                }

                // 文字列を表示
                $("#output5").val(text);
            });
        });

        $(function () {
            // [移動]ボタンを押した時の処理を設定
            $("#moveButton").click(function () {
                // 文字列を取得
                var text = $('#userText6').val();

                // 移動
                location.href = text;
            });

            // [別ウィンドウで開く]ボタンを押した時の処理を設定
            $("#openButton").click(function () {
                // 文字列を取得
                var text = $("#userText6").val();

                // 別ウィンドウで開く
                window.open(text, "_blank")
            });
        });
    }());
});