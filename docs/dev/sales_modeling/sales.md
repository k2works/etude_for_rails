---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

[TOC]

SalesModeling
---
# 販売業務の設計
## 要求
### 販売業務の概要
+ 企業間での販売（B2B)
+ 消費者への販売（B2C)

### 販売業務のプロセス
1. マーケティング
1. 引き合い
1. 商談／提案／見積り
1. 受注／売上
1. 納品
1. 請求

### 販売業務のユースケース
```puml
left to right direction
skinparam packageStyle rectangle
actor 顧客
actor 販売担当
rectangle 販売業務 {
  販売担当 -- (見積りを提示する)
  販売担当 -- (注文を受ける)
  販売担当 -- (納品を指示する)  
  販売担当 -- (代金を請求する)  
}
```

## 分析
### クラス図

```puml
class 顧客 {
  名称:String
  住所:String
  電話番号:String
}
class 売上 {
  日付:Date
  金額:int
}
class 売上明細 {
  数量:int
  単価:int
  金額:int
}
class 見積 {
  日付:Date
  金額:int
}
class 見積明細 {
  数量:int
  単価:int
  金額:int
}
class 商品 {
  商品名:String
  単価:int
}
顧客 -- 売上
顧客 -- 見積
売上 *-- 売上明細
見積 *-- 見積明細
売上明細 -- 商品
見積明細 -- 商品
売上 "0..*" - "1" 見積
```

### シーケンス図
```puml
顧客 -> 販売担当 :見積り依頼
販売担当 -> 販売担当 :在庫の確認
販売担当 -> 販売担当 :見積りの作成
販売担当 --> 顧客 :見積り指示
顧客 -> 販売担当 :注文
販売担当 -> 販売担当 :見積り内容の参照
販売担当 -> 販売担当 :有効在庫の引当
販売担当 -> 販売担当 :売上の登録
販売担当 --> 顧客 :注文受諾
```

## 設計
### クラス図
```puml
class Customer {  
}
interface Sales {

}
interface Product {

}
class SalesOrder {
}
class SalesOrderLine {

}
class SalesEstimateStrategy {

}
class SalesEstimateLine {

}
class ApparelProduct {

}
class Sku {

}
class SalesService << DomainService >>{

}
abstract SalesFactory {  

}
class ApparelSalesEstimateFactory {

}
class ApparelSalesFactory {

}
abstract SalesStrategy {

}
class OrderStrategy {

}
class EstimateStrategy {

}
class Address {

}
class Telephone {

}
class DateOfOccurrence {

}
class Money {

}
class Quantity {

}

Customer -- SalesStrategy
Sales - Product
ApparelProduct *-- Sku
SalesOrder *-- SalesOrderLine
SalesEstimate *-- SalesEstimateLine
Sales <|... SalesOrder
Sales <|... SalesEstimate
Product <|... ApparelProduct
SalesFactory <|.. ApparelSalesEstimateFactory
SalesFactory <|.. ApparelSalesFactory
ApparelSalesEstimateFactory ---> Sales
ApparelSalesEstimateFactory ---> Product
ApparelSalesFactory ---> Sales
ApparelSalesFactory ---> Product
SalesService -> SalesStrategy
SalesStrategy -> SalesFactory
SalesStrategy <|.. OrderStrategy
SalesStrategy <|.. EstimateStrategy
Customer o-l Address
Customer o- Telephone
SalesOrderStrategy o-- Money
SalesOrderStrategy o--- DateOfOccurrence
SalesOrderStrategyLine o-- Money
SalesOrderStrategyLine o--- Quantity
SalesEstimateStrategy o-- Money
SalesEstimateStrategy o--- DateOfOccurrence
SalesEstimateStrategyLine o-- Money
SalesEstimateStrategyLine o--- Quantity
Sku o-- Money
Sku o--- Quantity
SalesOrder "0..*" - "1"SalesEstimate
```

## シーケンス図
### 見積もり
```puml
SalesService -> Customer :find_by_code(code)
SalesService -> EstimateStrategy :new(customer)
SalesService -> EstimateStrategy :execute()
EstimateStrategy -> ApparelSalesEstimateFactory :create_product()
ApparelSalesEstimateFactory -> ApparelProduct :find()
EstimateStrategy -> ApparelProduct
EstimateStrategy -> ApparelSalesEstimateFactory :create_sales_estimate()
ApparelSalesEstimateFactory -> SalesEstimate :new()
EstimateStrategy -> SalesEstimate :create()
EstimateStrategy -> Customer :order_estimate(estimate)
```
### 注文
```puml
SalesService -> Customer :find_by_code(code)
SalesService -> OrderStrategy :new(customer)
SalesService -> OrderStrategy :execute()
OrderStrategy -> ApparelSalesEstimateFactory :create_estimate()
ApparelSalesEstimateFactory -> SalesEstimate :find()
OrderStrategy -> OrderStrategy
OrderStrategy -> ApparelSalesFactory :create_product()
ApparelSalesFactory -> ApparelProduct :find()
OrderStrategy -> ApparelProduct :inventory_reserve()
OrderStrategy -> ApparelSalesFactory :create_sales()
ApparelSalesFactory -> Sales :new()
OrderStrategy -> Sales :create()
OrderStrategy -> Customer :order_accept(sale)
```

## ER図
```puml
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
entity Customer {
  + code [PK]
  --
  name
  prefecture
  city
  house_number  
  telephone_number
  customer_type_category_cod [FK]
}
entity Sales {
  + code [PK]
  --
  type
  sales_type_category_code [FK]
  sales_date
  sales_amount
  sales_estimate_code [FK]
}
entity SalesLine {
  + code [PK]
  # sales_code [FK]
  --
  quantity_amount
  unit_sales_price_amount
  unit_sales_price_currency
  sales_amount
  sku_code [FK]
}
entity Estimate {
  code
  sales_code [FK]  
}
CategoryClass ||-do-{ Category
Estimate ||-do-{ Sales  
Product ||-do-{ Sku
Category ||-do-{ Sku
Category }-do-|| Category
Customer ||-do-{ Sales
Sales ||-do-{ SalesLine
SalesLine -do- Sku  
Category ||-do-{ Sales
Sales ||-do-{ Estimate
Category||-do-{Product
Category||-do-{Customer    
```
