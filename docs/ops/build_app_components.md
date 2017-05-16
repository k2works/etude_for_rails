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

Mochaの動作のテスト
```bash
npm test
npm run test:watch
```

### 開発環境セットアップ
#### SimpleCovのセットアップ

## 注意

## 参照
+ [SimpleCov](https://github.com/colszowka/simplecov)
