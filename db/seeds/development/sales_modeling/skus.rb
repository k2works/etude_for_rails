# frozen_string_literal: true

10.times do
  i = 1
  sku = build(:sku_1)
  product = sku.sales_modeling_type3_product
  sku.sku_code = SalesModeling::Code::SkuCode.new(product.code,i.to_s)
  sku.save!
  i += 1
end
