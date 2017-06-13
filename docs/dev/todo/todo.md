Todo
---

## 基本仕様
+ タスクの作成
+ タスクの一覧
+ タスクの更新
+ タスクの削除

## ユースケース
### Todoタスクの作成
```text
create -n[--name] <タスク名> -c[--content] <内容>
```

### Todoタスクの一覧
```text
list -s <ステータス>(DONE|PENDING|NOT_YET)
```

### Todoタスクの更新
```text
update <id> -n[--name] <タスク名> -c[--content] <内容> -s[--status] <ステータス>(DONE|PENDING|NOT_YET)
```

### Todoタスクの削除
```text
delete <id>
```

### Todo管理アプリケーションのバージョン情報
```text
-v[--version]
```

### Todo管理アプリケーションのヘルプ
```text
-h[--help]
```

## コアモデル

## 参照
+ [パーフェクトRuby](https://www.amazon.co.jp/dp/B00P0UR1CA/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)