// DOMの準備後に実行する内容
$(function () {
    // Canvasを取得
    var canvas = $("#myCanvas").get(0);
    if (! canvas || ! canvas.getContext) return;

    // サイズを取得
    var w = canvas.width;
    var h = canvas.height;

    // 2Dコンテクストを取得
    var context = canvas.getContext("2d");

    // 背景を作成
    context.fillStyle = "#ffffcc";                   // 塗りつぶしスタイルの設定
    context.fillRect(0, 0, w, h);                    // 矩形塗りつぶし

    // 枠の作成
    context.strokeStyle = "#eeaa66";                 // 線描画スタイルの設定
    context.lineWidth = 10;                          // 線の太さを設定
    context.strokeRect(0, 0, w, h);

    // 文字描画の共通部分を初期化
    var text = "HTML5 + JavaScript !";               // 描画する文字列
    context.font = "64px 'Times New Roman'";         // フォントの設定
    context.textAlign = "center";                    // 文字列横位置
    context.textBaseline = "middle";                 // 文字列縦位置
    context.lineJoin = "round";                      // 線の角の描画方法

    // 文字周辺枠
    context.strokeStyle = "#aa6633";                 // 線描画スタイルの設定
    context.lineWidth = 10;                          // 線の太さを設定
    context.strokeText(text, w / 2, h / 2);          // 文字列を線描画

    // エンボス光
    context.strokeStyle = "#ffffff";                 // 線描画スタイルの設定
    context.lineWidth = 2;                           // 線の太さを設定
    context.strokeText(text, w / 2 - 1, h / 2 - 1);  // 文字列を線描画

    // エンボス影
    context.strokeStyle = "#884422";                  // 線描画スタイルの設定
    context.strokeText(text, w / 2 + 1, h / 2 + 1);   // 文字列を線描画

    // 文字本体
    context.fillStyle = "#dd9955";                     // 塗りつぶしスタイルの設定
    context.fillText(text, w / 2, h / 2);              // 文字列の塗りつぶし
});

$(function () {
    // class「dummy」の全要素を処理
    $(".dummy").each(function () {
        var text = $(this).text();
        var params = text.split("x");
        var w = params[0];
        var h = params[1];

        // Canvasと2Dコンテクストを作成
        try {
            var canvas = $("<canvas>")
                .attr("width", w).attr("height", h)
                .get(0);
            var context = canvas.getContext("2d");
        } catch(e) {
            console.log(e);
            return;
        }

        // 背景の作成
        context.fillStyle = "#aaa";
        context.fillRect(0, 0, w, h);

        // 模様の設定
        context.strokeStyle = "#333";
        context.lineWidth = 1;

        // 描画の最大半径
        var max = Math.sqrt(w * w + h * h) / 2;

        // 円を順番に描画
        for(var r = 0; r < max; r += 5) {
            // パスの開始
            context.beginPath();

            // 円弧のパスを作成
            context.arc(w / 2, h / 2, r, 0, Math.PI * 2, false);

            // 線描画
            context.stroke();
        }

        // フォントのサイズを自動で計算
        context.font = Math.floor(h * 0.6) + "px 'Times New Roman";

        // 文字列の描画設定
        context.textAlign = "center";
        context.textBaseline = "middle";
        context.fillStyle = "#fff";

        // サイズを文字で表示
        context.fillText(text, w / 2, h / 2, w * 0.9);

        // 表示
        $(this).empty().append(canvas);
    });
});

$(function () {
    // class[balloon]のdiv領域全てに処理を実施
    $("div.balloon").each(function () {
        // サイズを取得
        var w = $(this).outerWidth();
        var h = $(this).outerHeight();
        var m = 2;   // マージン
        var r = 16;  // 角丸も半径

        // Canvasを作成
        var canvas = $("<canvas>").attr("width", w).attr("height", h).get(0);
        if(! canvas ||  ! canvas.getContext) return;
        var context = canvas.getContext("2d");

        // パスの作成
        context.beginPath();                              // 左上
        context.moveTo(m + r, m);

        // 角丸のパス
        context.arcTo(w - m, m, w - m, h, r);             // 右上
        context.arcTo(w - m, h - m -r, 0, h - m -r, r);   // 右下

        // 尻尾開始までのパス
        context.lineTo((w + r) / 2, h - m - r);

        // 尻尾のパス
        context.quadraticCurveTo(w / 2, h - m -r, w / 2, h -m);
        context.quadraticCurveTo((w - r) / 2, h - m - r / 2, ( w - r) / 2, h - m -r);

        // 角丸のパス
        context.arcTo(m, h - m - r, m, 0, r);              // 左下
        context.arcTo(m, m, w, m, r);                      // 左上

        // パスを塗りつぶし
        context.fillStyle = "#faa";
        context.fill();

        // パスを線描画
        context.strokeStyle = "#c88";
        context.lineWidth = 2;
        context.stroke();

        // PNGの取り出し
        var png = canvas.toDataURL();

        // 背景に反映
        $(this).css("background", "url(" + png + ")");
    });
});