---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

[TOC]

SalesModeling
---
# 在庫管理業務の設計
## 要求
### 在庫管理の業務内容
1 仕入れ入庫
```puml
@startuml
|仕入担当|
start
:商品を注文する;
|仕入先|
:注文を受ける;
:商品を出荷する;
|倉庫担当|
:商品を検品する;
:商品を入庫する;
stop
@enduml
```

2 販売出荷
```puml
@startuml
|顧客|
start
:商品を注文する;
|販売担当|
:注文を受ける;
:出荷を支持する;
|倉庫担当|
:商品をピッキングする;
:商品を梱包する;
:商品を発送する;
|顧客|
:商品を受領する;
stop
@enduml
```

3 移送入庫／出庫

4 返品入庫／出庫

5 棚卸

6 そのほかの作業

### 在庫管理業務のユースケース
```puml
@startuml
left to right direction
skinparam packageStyle rectangle
actor 倉庫担当
rectangle 在庫管理業務 {  
  倉庫担当 -- (商品を入庫する)
  倉庫担当 -- (商品を出庫する)
  倉庫担当 -- (商品在庫を棚卸する)
  (商品を入庫する) -- (仕入商品を入荷する) :<<extend>>
  (商品を入庫する) -- (移送品を入庫する) :<<extend>>
  (商品を入庫する) -- (返品を入庫する) :<<extend>>
  (商品を出庫する) -- (販売商品を出庫する) :<<extend>>
  (商品を出庫する) -- (移送品を出庫する) :<<extend>>
  (商品を出庫する) -- (返品を出庫する) :<<extend>>  
}
@enduml
```

|No|ユースケース|概要|
|:---|:---|:---|
|UC-01|商品を入庫する|倉庫担当は倉庫宛に送付された商品が、種類／数量が正しいか、品質に問題がないかをチェックする。問題がなければ商品を所定の場所で保管する。|
|UC-02|仕入れ商品を入庫する|倉庫担当は、倉庫宛に送付されてきた商品が、仕入先に対する発注内容と、種類／数量が正しいか、品質に問題がないかをチェックする。問題がなければ商品を所定の場所で保管する。|
|UC-03|移送品を入庫する|倉庫担当は、ほかの倉庫から送付されてきた商品が、発注内容と、種類／数量が正しいか、品質に問題がないかをチェックする。問題がなければ商品を所定の場所で保管する|
|UC-04|返品を入庫する|倉庫担当は、顧客から返品されてきた商品が、出荷内容と、種類／数量が正しいか、品質に問題がないかをチェックする。問題がなければ商品を所定の場所で保管する。|
|UC-05|商品を出庫する|倉庫担当は、出荷指示において指定された種類／数量の商品をピッキングし、梱包して出庫する。|
|UC-06|販売商品を出荷する|倉庫担当は、出荷指示において指定された種類／数量の商品をピッキングし、梱包。納品書などの書類を添付して出荷する。|
|UC-07|移送品を出庫する|倉庫担当は、移送指示において指定された種類／数量の商品をピッキングし、梱包。送り状などの書類を添付して出荷する。|
|UC-08|返品を出荷する|倉庫担当は、返品指示において指定された商品をピッキングし、梱包。送り状などの書類を添付して仕入先に出荷する。|
|UC-09|商品在庫を棚卸する|倉庫担当は、商品在庫の実数を調査し、システムに登録する。|

### 有効在庫
有効在庫数 = 在庫数 - 引当数

### 予定在庫
予定在庫数 = （現在の）在庫数 - 引当数 + 予定日までの入荷数

## 分析
### クラス図
#### タイプ１：数量管理型
```puml
@startuml
class 倉庫 {
  倉庫名: String
}
class 商品 {
  商品名: String
  仕入標準単価: int
  販売単価: int
}
class 在庫 {
  在庫数: int
  引当数: int
  有効在庫数: int
}
倉庫 "1"-"0..*" 在庫
商品 "1"--"0..*" 在庫
@enduml
```
#### タイプ２：ロット管理型
```puml
@startuml
class 倉庫 {
  倉庫名: String
}
class 商品 {
  商品名: String
  仕入標準単価: int
  販売単価: int
}
class 在庫 {
  在庫数: int
  引当数: int
  有効在庫数: int
}
class 仕入れロット {
  ロット番号: int
  入荷日: Date
  仕入単価: int
}
class 仕入先 {
  仕入先名: String
}
倉庫 "1"-"0..*" 在庫
商品 "1"--"0..*" 在庫
商品 "1"-"0..*" 仕入れロット
仕入れロット "1"-"1..*" 在庫
仕入れロット "0..*"-"1" 仕入先
@enduml
```
#### タイプ３：単品管理型
```puml
@startuml
class 倉庫 {
  倉庫名: String
}
class 商品 {
  商品名: String
  仕入標準単価: int
  販売単価: int
}
class 在庫 {
  在庫数: int
  引当数: int
  有効在庫数: int
}
class 単品 {
  シリアル番号: int
  仕入単価: int
}
class 仕入先 {
  仕入先名: String
}
倉庫 "1"-"0..*" 在庫
商品 "1"--"0..*" 在庫
商品 "1"-"0..*" 単品
在庫 "1" o--"0..*" 単品 
単品 "0..*"-"1" 仕入先
@enduml
```

#### 受払（タイプ１）
```puml
@startuml
class 倉庫 {
  倉庫名: String
}
class 商品 {
  商品名: String
  仕入標準単価: int
  販売単価: int
}
class 在庫 {
  在庫数: int
  引当数: int
  有効在庫数: int
}
class 受払 {
  受払種別: String
  受払日: Date
}
class 受払明細 {
  受入数量 :int
  払出数量 :int
  受払単価 :int
}
倉庫 "1"-"0..*" 在庫
商品 "1"--"0..*" 在庫
倉庫 "1"--"0..*" 受払
受払 "1" o--"0..*" 受払明細
在庫 ---"0..*" 受払明細
@enduml
```

#### 受払一覧表の例
```puml
@startsalt
{
**受払一覧表**
.
倉庫名:横浜倉庫    期間:平成１７年１２月１日〜平成１７年１２月５日
{#
受払日 | 受払種別 | 商品 | 受払数量 | 払出金額 | 受払金額 
平成１７年１２月１日 | 仕入入荷 | オプティカルマウス | 5 | . | 3,000  
平成１７年１２月１日 | . | マウスパッド | 10 | . | 1,000  
平成１７年１２月２日 | 販売出荷 | カラープリンタ | . | 5 | 23,000

平成１７年１２月５日 | 移送出荷 | オプティカルマウス | 2 | . | 3,000  
平成１７年１２月５日 | . | ワイヤレスキーボード | 2 | . | 5,000
| .| . |**合計** | 19 | 15 | 35,500
}
}
@endsalt
```

#### 棚卸
```puml
@startuml
class 倉庫 {
  倉庫名: String
}
class 商品 {
  商品名: String
  仕入標準単価: int
  販売単価: int
}
class 在庫 {
  在庫数: int
  引当数: int
  有効在庫数: int
}
class 棚卸 {
  棚卸日: Date
  理論在庫数 :int
  実棚数: int
  /棚卸歳数: int 
}
倉庫 "1"-"0..*" 在庫
商品 "1"--"0..*" 在庫
在庫 "1" *--"0..*" 棚卸
@enduml
```


## 設計
### クラス図
```puml
class SalesService << DomainService >>{
}
class PurchaseService << DomainService >>{
}
class Supplier {
  name:String
  address:String
  telephone:String
}
class Warehouse {
  warehouse_name:String
}
class Product {
  name:String
  unit_purchase_price:int
  unit_sales_price:int
}
class OrderLot {
}
class Inventory {
}

SalesService -> Inventory
PurchaseService -> OrderLot
PurchaseService -> Inventory
OrderLot - Supplier
OrderLot -- Inventory 
OrderLot -- Product
Inventory -- Warehouse
```

### ER図
```puml
entity Supplier {
  + code [PK]
  --
  name
  prefecture
  city
  house_number
  telephone_number
  # supplier_type_category_code [FK]
}
entity Warehouse {
  + code [PK]
  --
  name
  order_id [FK]
  stock_id [FK]
  # warehouse_type_category_code [FK]  
}
entity Product {
  + code [PK]
  --
  name
  # product_type_category_code [FK]
  # brand_category_code [FK]    
  # season_category_code [FK]
  # year_category_code [FK]  
}
entity Sku {
  + code [PK]
  --
  unit_purchase_price_amount
  unit_purchase_price_currency
  unit_sales_price_amount
  unit_sales_price_currency        
  # product_code [FK]    
  # size_category_code [FK]
  # color_category_code [FK]  
}
entity Category {
  + code [PK]
  --
  name
  # parent_code [FK]
}
entity CategoryClass {
  + code [PK]
  --
  name
}
entity OrderLot {
  + lot_number [PK]
  --
  arrival_date
  unit_purchase_price_amount
  unit_purchase_price_currency
  # supplier_id [FK]
  # product_id [FK]
}
entity Inventory {
  id [PK]
  --
  amount
  unit
  allocation_amount
  allocation_unit
  available_amount
  available_unit
  # order_lot_id [FK]
  # warehouse_id [FK]
  # product_id [FK]
}
CategoryClass ||-do-{ Category
Product ||-do-{ Sku
Category ||-do-{ Sku
Category }-do-|| Category
Category||-do-{ Product
Category||-do-{ Supplier
Category||-do-{ Warehouse
Category||-do-{ Inventory
Supplier ||-do-{ OrderLot
Product ||-do-{ OrderLot
Product ||-do-{ Inventory
OrderLot ||-do-{ Inventory
Warehouse ||-do-{ Inventory
```
