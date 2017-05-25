HTMLCSSBook
---

## 基本仕様
[現場のプロが本気で教える HTML/CSSデザイン講義](https://www.amazon.co.jp/dp/B01K3SZGR0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)の内容をRails5で実装する

## ユースケース
## よいCSSを書くためのHTMLマークアップ-CSS設計-
### デザインカンプを確認し、CSS設計を理解しよう
#### コンポーネント
+ ヘッダー
+ カルーセル
+ サムネイル画像付きコンテンツ
+ オーバーレイパネル
+ アイコン付きコンテンツ
+ ニュースリスト
+ フッター

#### CSS設計
+ BEM
+ [OOCSS](http://oocss.org/)
+ [MCSS](http://operatino.github.io/MCSS/ja/)
+ [SMACSS](https://smacss.com/)

#### BEM
 + [BEM](https://en.bem.info/)
 + [MindBEMding](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/)
 
#### classの命名規則について
+ Blockの最初の文字は大文字で書くこと
+ Elementの最初の文字は小文字で書く
+ BlockとElementは「__」でつなぐ
+ Modifierをつける場合は「--」でつなぐ

#### まとめ
 1. 最初は「見た目」からコンポーネントを割り出す
 1. 大文字や小文字などをうまく使い分ける
 1. 長いclass名はエディタの保管機能を使えば怖くない

### サイト制作の下準備をしよう

#### indexページ作成

#### フォルダを整理する

#### 分割したファイルを読み込む「import機能」

#### リセットCSSを導入する

#### 背景色を設定する

#### まとめ
+ どんなサイトを作る場合でも、まずリセットCSSを導入する
+ コンポーネントごとにファイルを分けて、一覧できるようにする
+ 変数は、変数だけのファイルを作成すると管理が楽になって効率的

### Headerを作成しよう

#### コンポーネントを意識してマークアップしよう

#### HTMLをマークアップ

#### まとめ
+ コンポーネントを、まずはBlockとして作ってみる
+ 複雑なコンポーネントはBlockの中にBlockを作ってみる
+ Elementは汎用的な命名をなるべく使い、どこのBlockに属するのかをわかりやすくする

## Sassを使ったサイト制作 その１（ヘッダーなど）

### ヘッダーのスタイルを作成しよう

#### Flexを利用したヘッダーのCSS  

#### 「画像+記事」のコンポーネントを作る

#### ボタンを作成する

#### まとめ
+ レイアウトは極力Flexを使って書く
+ Flexのショートハンドの書き方に慣れる
+ それ以上細かくできないコンポーネントはpartsとして作る

### レイアウトを作成しよう  
  
#### レイアウトを整えるCSSを作る

#### 全体的な幅を決める
#### まとめ
+ レイアウトについてはCSSからわかるように「l-」を付ける
+ レイアウトはコンポーネントではないのでpartsフォルダに作成する
+ Sassの四則演算を上手に使ってレイアウトを整える

## Sassを使ったサイト制作 その２（メインコンテンツやフッターなど）

### メインイメージを作成しよう
#### カルーセルを組み込むには

#### インジケータの制作 

#### JavaScriptを有効化する

#### まとめ
+ JavaScriptを読み込む位置は、bodyタグの終了タグの位置
+ JavaScriptと連携しているところは「js-」という接頭語をつける
+ 状態についてのCSSは「isXXX」という命名規則を使う

### コンテンツ部分を作成しよう

#### コンテンツ部の作成をはじめる

#### タイトル部分を作成する

#### OverlayPanelを作成する

#### 背景画像を設定する

#### アイコン付きのコンテンツメニューを作成する

#### ニュースのコンポーネントを作成する

#### まとめ
+ 疑似要素を使って、かしこくclassの指定をする
+ ページ専用の要素はコンポーネントとは別管理にする
+ 変数をセレクタで使える「インターポレーション」

### フッターを作成しよう

#### フッター作成を始める

#### Menuを修正する

### フォルダを整理しよう

#### これまで作成したもののおさらい

+ baseフォルダ                            
+ componentsフォルダ
+ commonフォルダ
+ pageフォルダ

#### まとめ
+ ただ作るのではなく、どのフォルダに属するのかを意識しながら作る
+ main.cssにコメントを残し、どういうファイルがあるかがひと目でわかるようにする

## プロらしく「魅せる」テクニック-トップページの総仕上げ-

### アイコンフォントを活用しよう

#### アイコンフォントを使う

#### まとめ
+ アイコンフォントと画像の違いを理解する
+ アイコンフォントは解像度に左右されない
+ FontAwesomeは便利なので、使い方をマスターする

### WebFontを利用しよう

#### WebFontを使うための準備

#### WebFontを使ってみよう

#### まとめ
+ WebFontはフォントの表現幅が大幅に上がる
+ WebFontをmixinとしておくことで、使いやすなる
+ WebFontを使いすぎるとパフォーマンスが下がるので注意する

### 突発的な修正に上手に対応しよう

#### 突発的な修正に上手に対応するには？

#### ユーティリティclassを作成する

#### まとめ
+ 汎用的なclassとわかるように「u-」の接頭辞をつける
+ 汎用的なclassを使ってうまくレイアウトを整える
+ コンポーネントの修正以外の視点を持つ

### Webページをレスポンシブ化しよう

#### mixinを作成する

#### 各コンポーネントのスマートフォン対応

#### まとめ
+ Media Queriesはレスポンシブの基本なので必ず覚える
+ @contentをうまく利用して、効率よくレスポンシブサイトを作成する
+ レスポンシブについてのCSSはmixinにして再利用可能にする

## パーツの組み合わせによる「高速」Webページ制作

### キャンペーンページを作成しよう

#### キャンペーンページのHTMLを確認する

#### 3つのコンテンツが並んでいるコンポーネントの制作

#### 横幅いっぱいの画像のコンポーネントと「アイコン+テキストコンポーネント」

#### フォームを作成する

#### まとめ
+ 新たに作るのではなく、すでに似たものを作っていないかという視点を持つ
+ 既存のコンポーネントを組み合わせて新たなページを作成する
+ Modifierを使ってデザインを調整する

### サイドバーのある画面を作ろう

#### Articleページを作成する

#### Flexを活用してサイドバーのあるレイアウトを作る

#### まとめ
+ Flexを使えば、面倒なサイドバーのレイアウトも簡単に
+ コンポーネントベースで作ると、ページ固有のCSSを少し追加するだけでほぼ１ページ作れる
         
## コアモデル

## 参照
 + [現場のプロが本気で教える HTML/CSSデザイン講義](https://www.amazon.co.jp/dp/B01K3SZGR0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)
 + [現場のプロが本気で教える HTML/CSSデザイン講義 サンプルデータ](https://github.com/basara669/html_css_book)
 + [rspec-rails](https://github.com/rspec/rspec-rails)
 + [Rack::LiveReload](https://github.com/johnbintz/rack-livereload)
 + [Guard::LiveReload](https://github.com/guard/guard-livereload)
 + [Better Errors](https://github.com/charliesome/better_errors)
 + [Rails での適切な Sass の構成手法について（翻訳](http://qiita.com/natsu871/items/53b38a2543df97df751d)
 + [sanitize.css](https://jonathantneal.github.io/sanitize.css/)
 + [flipsnap.js](https://github.com/hokaccha/js-flipsnap/)
 + [Underscore.js](https://github.com/jashkenas/underscore)
 + [font-awesome-rails](https://github.com/bokmann/font-awesome-rails)
 + [Google Fonts](https://fonts.google.com)
 + [RailsアプリをHerokuにデプロイする手順メモ](http://qiita.com/EntreGulss/items/8186938683f929a0dae2)
 + [Deploy to Herokuボタンをつけてみた](http://qiita.com/knt45/items/df1e68e5ccc935323197)

