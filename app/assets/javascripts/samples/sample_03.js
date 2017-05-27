$(document).on("turbolinks:load", function() {
    (function(){
        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton6").click(function () {
                // チェックボックスの値を取得
                var check = $("#check6").prop("checked");

                // 表示の分岐
                if (check) {
                    $("#output6").val(
                        "ありがとうございます。サービスをご利用ください。"
                    );
                } else {
                    $("#output6").val(
                        "規約に同意しなければ、サービスは利用できません。"
                    );
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton7").click(function () {
                // 金額を取得
                var price = $("#userText7").val();

                // 値を数値にする
                price = parseInt(price);

                // NaNであるか確認
                if (isNaN(price)) {
                    // NaNであるので「0」に書き換える。
                    price = 0;
                    $("#userText7").val(price);
                }

                // 表示の分岐
                if (price >= 1000) {
                    $("#output7").text("1,000円以上なので、送料無料です。");
                } else {
                    $("#output7").text("1,000円未満なので、送料は200円です。");
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton8").click(function () {
                // 重量と個数の変数を初期化
                var weight = 0;      // 重量
                var count = 0;       // 個数

                // 重量と個数を加算していく
                if ($("#item1").prop("checked")) {
                    weight += $("#item1").val() * 1;
                    count += 1;
                }
                if ($("#item2").prop("checked")) {
                    weight += $("#item2").val() * 1;
                    count += 1;
                }
                if ($("#item3").prop("checked")) {
                    weight += $("#item3").val() * 1;
                    count += 1;
                }
                if ($("#item4").prop("checked")) {
                    weight += $("#item4").val() * 1;
                    count += 1;
                }
                // 表示の分岐
                if (weight >= 5) {
                    if (count >= 2) {
                        $("#output8").text("5kg以上 2個以上なので送料は360円です。");
                    } else {
                        $("#output8").text("送料は無料です。");
                    }
                } else {
                    $("#output8").text("送料は無料です。");
                }
            });
        });

        $(function () {
            // [実行]ボタンを押した時の処理を設定
            $("#execButton8-2").click(function () {
                // 重量と個数の変数を初期化
                var count = 0;         // 個数
                var weight = 0;        // 重量

                // jQueryの「each()」関数を使って各チェックボックスを処理
                $("input[type='checkbox']").each(function () {
                    // チェックボックスがチェックされているか確認
                    if ($(this).prop("checked")) {
                        // チェックされているならば、個数を増やして重量を加算する
                        count += 1;
                        weight += $(this).val() * 1;
                    }
                });

                // 表示の分岐
                if (weight >= 5 && count >= 2) {
                    $("#output8").text("5kg以上 2個以上なので送料は360円です。");
                } else {
                    $("#output8").text("送料は無料です。")
                }
            });
        });

        $(function () {
            // [送信]ボタンを押した時の処理を設定
            $("#submitButton9").click(function () {
                // 入力欄の値を取得
                var text1 = $("#userText9-1").val();
                var text2 = $("#userText9-2").val();
                var text3 = $("#userText9-3").val();

                // 入力確認
                var checkOk = true;
                if(text1 == "") checkOk = false;
                if(text2 == "") checkOk = false;
                if(text3 == "") checkOk = false;

                // 表示の分岐
                if (checkOk) {
                    $("#output9").text("送信しました。");
                    return true;
                } else {
                    $("#output9").text("全て入力してください。");
                    return false;
                }
            });
        });

        $(function () {
            // [送信]ボタンを押した時の処理を設定
            $("#submitButton9-2").click(function (e) {
                // 入力欄の値を取得
                var text1 = $("#userText9-1").val();
                var text2 = $("#userText9-2").val();
                var text3 = $("#userText9-3").val();

                // 入力確認
                var checkOk = true;
                if(text1 == "") checkOk = false;
                if(text2 == "") checkOk = false;
                if(text3 == "") checkOk = false;

                // 表示の分岐
                if (checkOk) {
                    $("#output9").text("送信しました。");
                } else {
                    $("#output9").text("全て入力してください。");
                    e.preventDefault();
                }
            });
        });

        $(function () {
            // 時間の取得
            var d = new Date();
            var h = d.getHours();

            // 読み込む画像ファイルの名前用変数
            var fileName = "";

            // 時間による分岐
            if (0 <= h && h < 7) {
                fileName = "http://placehold.it/300/33cc66/000000";   // 夜
            } else if (7 <= h && h < 19) {
                fileName = "http://placehold.it/300/ff6666/000000"; // 朝
            } else if (12 <= h && h < 19) {
                fileName = "http://placehold.it/300/3366cc/000000"; // 昼
            } else if (19 <= h && h < 24) {
                fileName = "http://placehold.it/300/ffffff/000000";   // 夜
            }

            // img要素の作成
            var img = $("<img>");
            img.attr("src", fileName);

            // img要素の表示
            $("#timeBg").append(img);
        });

        $(function () {
            // cookieから訪問回数を取得
            var count = Cookies.get("VisitCount");
            if(count === undefined) count = 0;
            count = parseInt(count) + 1;

            // 訪問回数の表示
            $("#output10").text(count + "回目の訪問です。");

            // 訪問回数の記録
            Cookies.set("VisitCount", count, {expires: 7});

            // [リセット]ボタンを押した時の処理を設定
            $("#resetButton10").click(function () {
                // cookieの削除
                Cookies.remove("VisitCount");

                // 訪問回数の表示
                $("#output10").text("訪問回数をリセットしました。");
            });
        });
    }());
});