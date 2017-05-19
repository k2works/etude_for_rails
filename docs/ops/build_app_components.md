アプリケーションコンポーネント構築
---

## 例
### テスト環境セットアップ
#### RSpecのセットアップ
```bash
bundle install
rails generate rspec:install
bundle binstubs rspec-core
./bin/rspec
```

### JavaScript環境セットアップ
#### Webpackerのセットアップ

```bash
bin/rails webpacker:install
```

#### Reactのセットアップ

```bash
bin/rails webpacker:install:react
```

webpack-dev-serverを有効にする
```bash
bundle install
bin/webpack
bundle exec foreman start -f Procfile.dev
```
または
```bash
./bin/server
```

#### React-Bootstrapのセットアップ
```bash
./bin/yarn add react-bootstrap --save-dev
```
#### JavaScriptテスト環境のセットアップ
```bash
npm install --save-dev mocha chai sinon enzyme jsdom mocha quik react-addons-test-utils babel-cli css-modules-require-hook path power-assert
```

#### ESLintのセットアップ
```bash
npm i -g eslint babel-eslint eslint-plugin-react eslint-plugin-babel
```

#### Flowのセットアップ
```bash
npm install -g flow-bin
flow init
npm install --save empty
npm install --save-dev invariant
npm install --save-dev babel-preset-stage-0
```
https://gist.github.com/lambdahands/d19e0da96285b749f0ef

Mochaの動作のテスト
```bash
npm test
npm run test:watch
```

### 開発環境セットアップ
#### SimpleCovのセットアップ
#### Code Climateのセットアップ
[バッジのリンク](https://codeclimate.com/github/k2works/etude_for_rails/badges/)

## 注意

## 参照
+ [SimpleCov](https://github.com/colszowka/simplecov)
+ [k2works/etude_for_rails](https://codeclimate.com/github/k2works/etude_for_rails)
+ [rails 5.1 babel-preset-env "Missing class properties transform" の回避](http://qiita.com/github0013@github/items/f3843ec8593a663e13e3)
