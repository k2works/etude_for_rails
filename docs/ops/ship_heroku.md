Heroku配置
---

## 例
アプリケーションのセットアップ
```bash
rbenv local 2.4.0
heroku create etude-for-rails
```

アプリケーションの初回デプロイ
```bash
# ビルドパックの追加
$ heroku buildpacks:add --index 1 heroku/nodejs
$ heroku buildpacks:add --index 2 heroku/ruby

# デプロイとマイグレーション実行
$ git push heroku master
$ heroku run rake db:migrate

# Heroku上のアプリケーションを開く
$ heroku open
```
## 注意

## 参照
