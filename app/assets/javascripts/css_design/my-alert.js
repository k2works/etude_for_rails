$(document).on("turbolinks:load", function() {
    (function(){
        // HTMLElementのprototypeを継承したオブジェクトを作る
        var element = Object.create(HTMLElement.prototype);

        // カスタム要素のインスタンスが生成された時に実行する
        element.createdCallback = function() {
            // '#my-alert-template'にマッチする要素(template)
            var template = document.querySelector('#my-alert-template');
            // templateのDocumentFragmentからcontentを参照し取得する
            var content = template.content;
            // Shadow Rootにcontentを追加する(Shadow DOMの形成)
            var shadowRoot = this.createShadowRoot();
            shadowRoot.appendChild(
                document.importNode(content, true)
            );
        };

        // my-alertを作り、継承させる
        document.registerElement('my-alert', {
            prototype: element
        });
    }());
});