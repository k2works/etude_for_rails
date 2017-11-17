# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Supplier, type: :model do
  let(:wholesales_supplier_type) { create(:supplier_type_category, name: '卸売') }
  let(:params_a) do
    {
        code: '1',
        name: 'A',
        prefecture: '広島県',
        city: '広島市',
        house_number: '1',
        telephone_number: '9999999999',
        supplier_type_category: wholesales_supplier_type
    }
  end
  let(:supplier_a) { create(:sales_modeling_purchase_supplier, params_a) }

  let(:retail_supplier_type) { create(:supplier_type_category, name: '小売') }
  let(:params_b) do
    {
        code: '2',
        name: 'B',
        prefecture: '大阪府',
        city: '大阪市',
        house_number: '10',
        telephone_number: '9999999999',
        supplier_type_category: retail_supplier_type
    }
  end
  let(:supplier_b) { create(:sales_modeling_purchase_supplier, params_b) }

  describe '#create' do
    example '卸売取引先A' do
      supplier = supplier_a

      expect(supplier.code).to eq '1'
      expect(supplier.name).to eq 'A'
      expect(supplier.prefecture).to eq '広島県'
      expect(supplier.city).to eq '広島市'
      expect(supplier.house_number).to eq '1'
      expect(supplier.telephone_number).to eq '9999999999'
      expect(supplier.supplier_type_category.name).to eq '卸売'
    end

    example '小売取引先B' do
      supplier = supplier_b

      expect(supplier.code).to eq '2'
      expect(supplier.name).to eq 'B'
      expect(supplier.prefecture).to eq '大阪府'
      expect(supplier.city).to eq '大阪市'
      expect(supplier.house_number).to eq '10'
      expect(supplier.telephone_number).to eq '9999999999'
      expect(supplier.supplier_type_category.name).to eq '小売'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
