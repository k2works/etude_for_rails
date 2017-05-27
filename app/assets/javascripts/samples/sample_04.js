$(document).on("turbolinks:load", function() {
    (function(){
        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton11").click(function () {
                // 文字列を取得
                var text = $("#userText11").val();

                // マークダウン記法変換
                text = markdown(text);

                // 文字列を出力
                $("#output11").val(text);

                // プレビューを表示
                $("#output11-2").html(text);

                // マークダウン記法変換関数(簡易)
                function markdown(argText) {
                    // 強調
                    argText = argText.replace(/\*(.+?)\*/g, "<b>$1</b>");

                    // タイトル
                    argText = argText.replace(/^## *(.+?)$/gm, "<h2>$1</h2>");
                    argText = argText.replace(/^# *(.+?)$/gm, "<h1>$1</h1>");

                    // 改行
                    argText = argText.replace(/¥n/g, "<br>¥n")

                    // 戻り値を戻して終了
                    return argText;
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton12").click(function () {
                // URLとタイトルを取得
                var title = $("#userTitle").val();
                var url = $("#userUrl").val();

                // リンクの作成
                makeLink(title, url);

                // リンクの作成
                function makeLink(argTitle, argUrl) {
                    // DOMの作成
                    var a = $("<a>");
                    a.text(argTitle);
                    a.attr("href", argUrl);

                    // divで囲う
                    var div = $("<div>").append(a);

                    // 文字列を出力
                    $("#output12").val(div.html());

                    // リンクを出力
                    $("#output12-2").html(a);
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton13").click(function () {
                // 文字列を取得
                var text = $("#userText13").val();

                // リンクに変換
                text = text.replace(/^(.+?),(.+?)$/gm, function (s, s1, s2) {
                    return '<a href="' + s2 + '">' + s1 + '</a>';
                });

                // 改行を変換
                text = text.replace(/\n/g, "<br>\n");

                // 改行を出力
                $("#output13").val(text);

                // プレビュー
                $("#output13-2").html(text);
            });
        });

        $(function () {
            // マウスオーバー時の説明表示を追加
            $("a.link").hover(function () {
                // マウスが要素に乗った時の処理
                var ele = $(this);
                var title = ele.attr("title");
                $("#output14").val(title);
            }, function () {
                // マウスが要素から外れた時の処理
                $("#output14").val("");
            });
        });

        $(function () {
            // 状態遷移時の処理を設定
            $("#sel").change(function () {
                // 選択した項目の文字列を取得
                var text = $("#sel option:selected").text();

                // 文字列を表示
                $("#output14-2").text(text);
            });
        });

        $(function () {
            // [送信]ボタンを押した時の処理を設定
            $("#myForm").submit(function (e) {
                // 入力欄の値を取得
                var text = $("#userText14-3").val();

                // 表示の分位
                if (text != "") {
                    $("#output14-3").text("送信しました。");
                } else {
                    $("#output14-3").text("全て入力してください。");
                    e.preventDefault();
                }
            });
        });

        $(function () {
            // スクロール時の処理
            $(window).scroll(function (e) {
                // ドキュメントの高さを取得
                var h = $(document).height();

                // 現在のスクロール位置を計算
                // (スクロールの上端とウインドウ高さの合計)
                var pos = $(window).scrollTop() + $(window).height();

                // 末尾か確認
                if (h == pos) {
                    // 高さ1000pxの要素を追加
                    $("body").append('<div style="height: 1000px;"></div>');
                }
            })
        });
    }());
});
