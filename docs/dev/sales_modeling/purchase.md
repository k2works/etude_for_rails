---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

[TOC]

SalesModeling
---
# 仕入業務の設計
## 要求
### 仕入業務の概要
+ 商品仕入れとは
+ 業種別の特徴

### 注文以前のプロセス
1. 仕入先との契約
1. 仕入計画
   + 定期発注方式
   + 定量発注方式
   + 簡易発注方式

### 仕入業務のユースケース
```puml
left to right direction
skinparam packageStyle rectangle
actor 仕入先
actor 購買担当
actor 倉庫担当
actor 経理担当
仕入先 -- 購買担当 
仕入先 -- 倉庫担当
仕入先 -- 経理担当 
rectangle 仕入業務 {
  購買担当 -- (注文する)
  倉庫担当 -- (注文を検収する)
  経理担当 -- (請求書と照合する)  
  経理担当 -- (代金を支払う)  
}
```

## 分析
### クラス図

```puml
class 仕入先 {
  名称:String
  住所:String
  電話番号:String
}
class 発注 {
  発注日:Date
  入荷予定日:Date
  金額:int
}
class 発注明細 {
  数量:int
  単価:int
  金額:int
}
class 入庫 {
  入庫日付:Date
  検収日付:Date
}
class 入庫明細 {
  数量:int
  単価:int
  金額:int
}
class 倉庫 {
  倉庫名:String
}
class 商品 {
  商品名:String
  仕入標準単価:int
  販売単価:int
}
仕入先 -- 発注
発注 *-- 発注明細
発注明細 -- 商品
発注 "-入荷先"-- 倉庫
仕入先 - 入庫
発注 "0..1"-"0..*" 入庫
入庫 "-入庫先"-- 倉庫
入庫 *- 入庫明細
発注明細 "0..1"-"0..*" 入庫明細
入庫明細 -- 商品
```

### オブジェクト図
```puml
object 倉庫 {
  倉庫名 = "横浜倉庫"
}
object 仕入先 {
  名称 = "細川商店"
  住所 = "横浜市"
  電話番号 = "045-xxx-xxxx"
}
object 発注 {
  発注日 = "2005年11月2日"
  入荷予定日 = "2005年11月10日"
  金額 = "18,000円"
}
object 発注明細_1 {
  数量 = 2
  単価 = "3,000円"
  金額 = "6,000円"
}
object 商品_1 {
  商品名 = "USBメモリ"
  仕入標準単価 = "3,000円"
  販売単価 = "4,000円"
}
object 発注明細_2 {
  数量 = 3
  単価 = "4,000円"
  金額 = "12,000円"
}
object 商品_2 {
  商品名 = "ワイヤレスマウス"
  仕入標準単価 = "4,000円"
  販売単価 = "5,000円"
}
仕入先 - 発注
発注 - 倉庫
発注 -- 発注明細_1
発注 -- 発注明細_2
発注明細_1 -- 商品_1
発注明細_2 -- 商品_2
```

## 設計
### クラス図
```puml
class Supplier {
  name:String
  address:String
  telephone:String
}
class Order {
  order_date:Date
  scheduled_arrival_date:Date
  amount:int
}
class OrderLine {
  quantity:int
  unit_price:int
  price_amount:int  
}
class Stock {
  arrival_date:Date
  acceptance_date:Date
}
class StockLine {
  quantity:int
  unit_price:int
  price_amount:int
}
class Warehouse {
  warehouse_name:String
}
class Product {
  name:String
  unit_purchase_price:int
  unit_sales_price:int
}
class PurchaseService << DomainService >>{
}
abstract class OrderStrategy {
}
class RegularOrderStrategy {
}
class FixSizeOrderStrategy {  
}
class SimpleOrderStrategy {
}
class PurchaseFactory {
}

PurchaseService -> PurchaseFactory
PurchaseFactory --> OrderStrategy
PurchaseFactory --> Order
PurchaseFactory --> Stock
OrderStrategy <|.. RegularOrderStrategy
OrderStrategy <|.. FixSizeOrderStrategy
OrderStrategy <|.. SimpleOrderStrategy
OrderStrategy <-- Order
Supplier -- Order
Order *-- OrderLine
OrderLine -- Product
Order -- Warehouse
Supplier - Stock
Order "0..1"-"0..*" Stock
Stock -- Warehouse
Stock *- StockLine
OrderLine "0..1"-"0..*" StockLine
StockLine -- Product
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
  supplier_type_category_code [FK]
}
entity Order {
  + ID [PK]
  --
  order_date
  scheduled_arrival_date
  amount
  currency
  supplier_code [FK]
  order_type_category_code [FK]  
}
entity OrderLine {
  + line_number
  + order_id [FK]
  --
  quantity_amount
  quantity_unit
  unit_price_amount
  unit_price_currency
  price_amount
  price_currenty
  product_code [FK]
}
entity Stock {
  + ID [PK]
  --
  arrival_date
  acceptance_date
  stock_type_category_code [FK]
}
entity StockLine {
  + line_number
  + stock_id [FK]
  --
  quantity_amount
  quantity_unit
  unit_price_amount
  unit_price_currency
  price_amount
  price_currency
  product_code [FK]  
}
entity Warehouse {
  + code [PK]
  --
  name
  order_id [FK]
  stock_id [FK]
  warehouse_type_category_code [FK]  
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
  # category_class_code [FK]    
  --
  name
  # parent_code [FK]    
}
entity CategoryClass {
  + code [PK]
  --
  name
}
Order ||-do-{ Stock
Order  ||-do-{ Warehouse
Stock -do- Warehouse
Supplier ||-do-{ Order
Supplier ||-do-{ Stock
Order ||-do-{ OrderLine
Stock ||-do-{ StockLine
OrderLine -do- Sku
StockLine -do- Sku
CategoryClass ||-do-{ Category
Product ||-do-{ Sku
Category ||-do-{ Sku
Category }-do-|| Category
Category||-do-{ Product
Category||-do-{ Supplier
Category||-do-{ Order
Category||-do-{ Stock
Category||-do-{ Warehouse
```
