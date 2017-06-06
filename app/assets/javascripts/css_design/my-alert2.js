$(document).on("turbolinks:load", function() {
    (function(){
        // HTMLElementのprototypeを継承したオブジェクトを作る
        var element = Object.create(HTMLElement.prototype);

        // カスタム要素のインスタンスが生成された時に実行する
        element.createdCallback = function() {
            // '#my-alert-template'にマッチする要素(template)
            var template = document.querySelector('#my-alert-template2');
            // templateのDocumentFragmentからcontentを参照し取得する
            var content = template.content;
            // Shadow Rootにcontentを追加する(Shadow DOMの形成)
            var shadowRoot = this.createShadowRoot();
            shadowRoot.appendChild(
                document.importNode(content, true)
            );

            // message属性の値の追加先
            this.alertTitle = shadowRoot.getElementById('alertTitle');

            // message属性があれば、タイトル部分に追加する
            if (this.hasAttribute('message')) {
                var message = this.getAttribute('message');
                this.setTitle(message);
            }
        };

        // 取得した値（テキスト）を要素に追加するメソッド
        element.setTitle = function (val) {
            this.message = val;
            this.alertTitle.textContent = this.message;
        };

        // my-alertを作り、継承させる
        document.registerElement('my-alert2', {
            prototype: element
        });
    }());
});