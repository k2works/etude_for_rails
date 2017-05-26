// DOMの準備後に実行する内容
$(function() {
    // 画像ファイル名を2つ取得
    var tgt = $("#checkered");		// id「checkered」のdiv要素を選択
    var text = tgt.text();			// 内部の文字列を取り出し
    var imgs = text.split("|");		// 画像URLの配列を作る
    if (imgs.length != 2) return;	// 要素数が「2」でなければ終了

    // 画像用の変数を初期化
    var count = 0;		// 画像読み込み終了を確認するための変数
    var imgObj = [];	// 画像格納用の配列

    // 画像を読み込み
    for (var i = 0; i < imgs.length; i ++) {
        imgObj[i] = new Image();		// Imageオブジェクトの作成
        imgObj[i].onload = finishLoad;	// 読み込み完了時の処理を登録
        imgObj[i].src = imgs[i];		// 画像のURLを登録
    }

    // 読み込み完了時の処理
    function finishLoad() {
        // 全ての画像が読み込み終わりか確認
        count ++;
        if (count != imgs.length) return;

        // 全ての画像が読み込み終わったのでCanvasを作成して描画

        // 変数の初期化
        var w = imgObj[0].width;
        var h = imgObj[0].height;
        var u = 64;		// 描画単位（市松模様のサイズ）

        // Canvasを作成して、2Dコンテクストを取り出す
        var canvas = $("<canvas>")
            .attr("width", w).attr("height", h).get(0);
        if (! canvas || ! canvas.getContext) return;
        var context = canvas.getContext("2d");

        // 画像の描画
        for (var y = 0; y < h / u; y ++) {
            for (var x = 0; x < w / u; x ++) {
                // 描画する画像を決定して、配列から取り出す
                var img = imgObj[(y % 2 + x) % 2];

                // 画像を2Dコンテクストに描画
                context.drawImage(img,
                    x * u, y * u, u, u,
                    x * u, y * u, u, u);
            }
        }

        // 表示
        tgt.empty().append(canvas);
    }
});

// DOMの準備後に実行する内容
$(function() {
    // ［実行］ボタンを押した時の処理を設定
    $("#execButton").click(function() {
        // 変数の初期化
        var img = $("#source");
        var w = img.width();
        var h = img.height();

        // Canvasを作成
        var canvas = $("<canvas>")
            .attr("width", w).attr("height", h).get(0);
        if (! canvas || ! canvas.getContext) return;
        var context = canvas.getContext("2d");

        // 画像の描画
        context.drawImage(img.get(0), 0, 0, w, h);

        // 画素の取得
        var imagedata = context.getImageData(0, 0, w, h);
        var data = imagedata.data;

        // 画素の加工
        for (var y = 0; y < h; y ++) {
            for (var x = 0; x < w; x ++) {
                // 画素の位置を計算
                var pos = (x + y * w) * 4;

                // RGBAの値を取り出し
                var r = data[pos + 0];
                var g = data[pos + 1];
                var b = data[pos + 2];
                var a = data[pos + 3];

                // RGBの値の平均値を計算
                var average = (r + g + b) / 3;

                // 平均が128未満か否かで、白黒を分別
                var bin = 255;
                if (average < 128) bin = 0;

                // RGBの値を上書き
                data[pos + 0] = bin;
                data[pos + 1] = bin;
                data[pos + 2] = bin;
            }
        }

        // 画素の反映
        context.putImageData(imagedata, 0, 0);

        // 表示
        $("#output").append(canvas);
    });
});

// DOMの準備後に実行する内容
$(function() {
    // ［再生］ボタンを押した時の処理を設定
    $("#playButton").click(function() {
        $("#video").get(0).play();
    });

    // ［停止］ボタンを押した時の処理を設定
    $("#pauseButton").click(function() {
        $("#video").get(0).pause();
    });
});