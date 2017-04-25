開発用コンテナ構築
---

## 例
コンテナを作成してコンテナ内部でシェルを実行する。
```bash
docker build . -t app:base
docker run --name app --rm -p 5000:5000 -v $(PWD):/container -i -t app:base /bin/bash
cd /containe
```
仮想マシン環境では`$(PWD)`を`/vagrant`に書き換えて実行する。

docker-composeを使った場合。
```bash
docker-compose build
docker-compose run app bash
```

## 注意
+ 仮想マシンと併用は可能だがポートがぶつかる場合があるので設定に注意する。

## 参照
