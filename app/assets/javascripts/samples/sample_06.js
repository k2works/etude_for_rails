$(function () {
    // オブジェクトを作成
    var obj = {
        name: "りんご"
        ,price: 100
        ,color: "赤"
    };

    // 文字列を出力1
    $("#output21").append("文字列を出力1\n");
    $("#output21").append("obj.name : " + obj.name + "\n");
    $("#output21").append("obj.price : " + obj.price + "\n");
    $("#output21").append("obj.color : " + obj.color + "\n");
    $("#output21").append("<hr>");

    // 文字列を出力2
    $("#output21").append("文字列を出力2\n");
    $("#output21").append("obj.name : " + obj["name"] + "\n");
    $("#output21").append("obj.price : " + obj["price"] + "\n");
    $("#output21").append("obj.color : " + obj["color"] + "\n");
    $("#output21").append("<hr>");

    // 値の書き換え
    obj.name = "apple";
    obj["price"] = 200;

    $("#output21").append("値の書き換え\n");
    $("#output21").append("obj.name : " + obj.name + "\n");
    $("#output21").append("obj.price : " + obj.price + "\n");
    $("#output21").append("<hr>");

    // プロパティの追加
    obj.taste = "甘酸っぱい";

    $("#output21").append("プロパティの追加\n");
    $("#output21").append("obj.taste : " + obj.taste + "\n");
    $("#output21").append("<hr>");

    // 空のオブジェクトを作成
    var obj2 = {};

    // オブジェクトに様々値を追加
    obj2.myFnc = function () { return "fnc"};
    obj2.myArr = [10, 11, 12];
    obj2.myObj = {name: "hogehoge", price: 99};

    $("#output21").append("オブジェクトに様々な値を追加\n");
    $("#output21").append("obj2.myFnc : " + obj2.myFnc() + "\n");
    $("#output21").append("obj2.myArr : " + obj2.myArr + "\n");
    $("#output21").append("obj2.myObj : " + obj2.myObj + "\n");
})

$(function () {
    // windowオブジェクトの中身を出力
    for (var key in window) {
        $("#output22").append(key + " : " + window[key] + "\n");
    }
});

$(function () {
    // 関数オブジェクトを作成
    var fruit = function(name, price) {
        // 外部からアクセス可能なプロパティ
        this.name = name;
        this.price = price;

        // 外部からアクセスできない変数
        var type = "fruit";

        // 外部からアクセス可能なメソッド
        this.toString = function () {
            return this.name + ", " + this.price + ", " + type;
        };
    };

    // new演算子でオブジェクトを作る
    var apple = new fruit("りんご", 100);
    var banana = new fruit("ばなな", 90);

    // 文字列を出力
    $("#output23").append("apple.name : " + apple.name + "\n");
    $("#output23").append("apple.price : " + apple.price + "\n");
    $("#output23").append("apple.toString : " + apple.toString() + "\n");
    $("#output23").append("<hr>");

    $("#output23").append("banana.name : " + banana.name + "\n");
    $("#output23").append("banana.price : " + banana.price + "\n");
    $("#output23").append("banana.toString : " + banana.toString() + "\n");
});