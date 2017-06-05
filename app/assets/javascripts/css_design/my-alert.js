$(document).on("turbolinks:load", function() {
    (function(){
        // HTMLElementのprototypeを継承したオブジェクトを作る
        var element = Object.create(HTMLElement.prototype);

        // my-alertを作り、継承させる
        document.registerElement('my-alert', {
            prototype: element
        })
    }());
});