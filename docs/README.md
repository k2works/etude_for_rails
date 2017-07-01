Etude for Rails
===================

# 目的 #
Railsアプリケーションのための練習プログラム集

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.4.1     |             |
| node           |8.0.0     |             |
| rails          |5.1.1　　　|             |
| vagrant        |1.8.7     |             |
| docker         |17.05.0   |             |
| docker-compose |1.8.0    |             |

# 構成 #
1. [運用](#運用)
1. [開発](#開発)
1. [管理](#管理)

## 運用
### 開発環境
#### 構築
##### [開発用仮想マシン構築](./ops/build_vagrant.md)
##### [開発用コンテナ構築](./ops/build_docker.md)
##### [アプリケーションコンポーネント構築](./ops/build_app_components.md)

#### 配置
##### [Jenkins配置](./ops/ship_jenkins.md)

#### 保守

### ステージング環境
#### 構築

#### 配置
##### [CircleCI配置](./ops/ship_circleci.md)
##### [Heroku配置](./ops/ship_heroku.md)

#### 保守

### 本番環境
#### 構築
#### 配置
#### 保守

### 共通環境
#### 構築
#### 配置
#### 保守
##### [ソフトウェアのバージョン更新](https://github.com/k2works/etude_for_rails/commit/5801ca56ab74b6e75145e37f475f453cd2881ce2)

**[⬆ back to top](#構成)**

## 開発
### Architecture
#### [アプリケーションアーキテクチャ](./dev/app_architecture.md)
### Presentation
#### [HTMLCSSBook](dev/html_css_book/html_css_book.md)
#### [Bootstrap](dev/bootstrap/bootstrap.md)
#### [JavaScript](dev/javascript/javascript.md)
#### [CSSBase](dev/css_base/css_base.md)
#### [SassBase](dev/sass_base/sass_base.md) 
#### [CSSDesign](dev/css_design/css_design.md)
#### [ビールリスト](dev/beer_list/beer_list.md)
#### [React入門](dev/intro_to_react/intro_to_react.md) 
#### [Reactビギナーズガイド Exce](dev/react_beginners_guide/excel.md)
#### [Reactビギナーズガイド Whinepad](dev/react_beginners_guide/whinepad.md)
### Application
#### [ToDo](dev/todo/todo.md)
#### [ToDo2](dev/todo/todo2.md)
#### [AwesomeEvents](dev/awesome_events/awesome_events.md)
### Domain
#### [BowlingGame](dev/bowling_game/bowling_game.md)
#### [PayRoll](dev/payroll/payroll.md)
#### [RentalVideo](dev/rental_video/rental_video.md)
### infrastructure

**[⬆ back to top](#構成)**

## 管理
### プロジェクト管理
#### [XP](mgt/xp/xp.md)
#### [Scrum](mgt/scrum/scrum.md)

### バージョン管理

### チケット管理

### CI(継続的インテグレーション）

### CD(継続的デリバリー）

**[⬆ back to top](#構成)**

# 参照 #
+ [capybara cheat shee](https://gist.github.com/zhengjia/428105)
+ [Rails テスティングガイド](https://railsguides.jp/testing.html)