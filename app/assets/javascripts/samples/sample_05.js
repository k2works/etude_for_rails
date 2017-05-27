$(document).on("turbolinks:load", function() {
    (function(){
        $(function () {
            // クリック数
            var count = 0;

            // 紹介文
            var messages = [
                "(1)「技評タブレット」の特徴を紹介します。"
                ,"(2)本商品は弊社コンテンツ閲覧専用タブレットです。"
                ,"(3)過去の書籍を全て読めます。"
                ,"(4)また、今後発売する書籍も安価で閲覧可能です。"
            ];

            // [実行]ボタンを押した時の処理を設定
            $("#execButton15").click(function () {
                // 配列の値を読み込む
                var text = messages[count];

                // 文字列を出力
                $("#output15").val(text);

                // クリック数の更新
                count ++;

                // クリック数が配列数以上なら[0]に戻す
                if (count >= messages.length) {
                    count = 0;
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton16").click(function () {
                // 文字列を取得
                var text = $("#userText16").val();

                // 配列に変換
                var arr = text.split(" ");

                // リストの格納先を作成
                var ul = $("<ul>");

                // リストを作成
                for(var i = 0; i < arr.length; i ++) {
                    var li = $("<li>");
                    li.text(arr[i]);
                    ul.append(li);
                }

                // 文字列を出力
                var div = $("<div>").append(ul);
                $("#output16").val(div.html());

                // Webページにリストを表示
                $("#output16-2").html(ul);
            });
        });

        $(function () {
            // 変数「count」を初期化する
            var count = 0;

            // 定期処理を開始する
            var id = setInterval(function() {
                // 画像を全て非表示にする
                $("#animImg > img").hide();

                // 変数「count」番目の画像だけ表示状態にする
                $("#animImg > img").eq(count).show();

                // 変数「count」を1増やす
                count ++;

                // 変数「count」を3の場合は「0」に戻す
                count = count % 3;
            }, 500);

            // [停止]ボタンを押した時の処理を設定
            $("#execButton17").click(function () {
                // 定期処理を解除
                clearInterval(id);
            });
        });

        $(function () {
            // 対応の確認
            if (! window.File || ! window.FileReader
                || ! window.FileList || ! window.Blob) {
                return;
            }

            // ファイル選択変更時の処理を設定
            $("#fileButton18").change(function (event) {
                // 変更されたファイル情報の一覧を配列として取得
                var files = event.target.files;

                // ファイル情報を1つずつ得て処理していく
                for(var i = 0; i < files.length; i ++) {
                    // ファイル情報を1つ取得
                    var f = files[i];

                    // ファイル情報を出力
                    console.log("ファイル名:" + f.name);
                    console.log("種類:" + f.type);
                    console.log("サイズ:" + f.size);

                    // ファイル読み取り用の「FileReader」を作成
                    var reader = new FileReader();

                    // ファイル読み取り完了時のイベント
                    reader.onload = function (e) {
                        // 文字列取得
                        var text = e.target.result;

                        // 行数を追加
                        var arr = text.split("\n");
                        for(var i = 0; i < arr.length; i ++) {
                            arr[i] = i + " : " + arr[i];
                        }
                        text = arr.join("\n");

                        // 文字列を表示
                        $("#output18").val(text);
                    };

                    // テキストとして読み込む
                    reader.readAsText(f, "shift-jis");
                }
            });

            $(function () {
                // 対応の確認
                if (! window.File || ! window.FileReader
                    || ! window.FileList || ! window.Blob) {
                    return;
                }

                // 通常のイベントをキャンセルする関数
                var cancelEvent = function (event) {
                    event.preventDefault();
                    event.stopPropagation();
                };

                // ファイルを読み込む関数
                var dropFileEvent = function (event) {
                    // 通常のイベントのキャンセル
                    cancelEvent(event);

                    // ファイル一覧の取得
                    var files = event.originalEvent.dataTransfer.files;

                    // 各ファイルに対して処理を実施
                    for (var i = 0; i < files.length; i ++) {
                        // ファイルの取得
                        var f = files[i];

                        // ファイルの読み取り
                        var reader = new FileReader();

                        // 読み取り完了時のイベントを登録
                        reader.onload = function (e) {
                            // Data URL形式のデータを取り出す
                            var text = e.target.result;

                            // img要素を作成
                            var img = $("<img>");
                            img.attr("src",text);

                            // 画像を表示
                            $("#output19").append(img);
                        };

                        // Data URL形式で読み取り
                        reader.readAsDataURL(f);
                    }
                };

                // イベントの設定
                $("#drop").on({
                    "dragenter": cancelEvent
                    ,"dragover": cancelEvent
                    ,"dragleave": cancelEvent
                    ,"drop": dropFileEvent
                });
            });

            $(function () {
                // [実行]ボタンを押した時の処理を設定
                $("#execButton20").click(function () {
                    // 文字列を取得
                    var text = $("#userText20").val();

                    // トリム
                    text = text.trim();

                    // 配列に変換
                    var arr = text.split("\n");

                    // ソート
                    arr.sort(function (a, b) {
                        // 各要素をカンマ区切りで配列化
                        var nameA = a.split(",")[1];
                        var nameB = b.split(",")[1];

                        // 読みの値を比較
                        if (nameA < nameB) return -1;
                        if (nameA > nameB) return 1;
                        return 0;
                    });

                    // 配列を結合
                    text = arr.join("\n");

                    // 文字列を出力
                    $("#output20").val(text);
                });
            });
        });
    }());
});