# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Supplier, type: :model do
  let(:suppliers_repo) { SalesModeling::SuppliersRepo.new }
  let(:wholesales_supplier_type) { create(:supplier_type_category, name: '卸売') }
  let(:params_a) do
    {
        name: 'A',
        prefecture: '広島県',
        city: '広島市',
        house_number: '1',
        telephone_number: '09099999999',
        supplier_type_category: wholesales_supplier_type
    }
  end
  let(:create_supplier_a) { suppliers_repo.save(params_a) }

  let(:retail_supplier_type) { create(:supplier_type_category, name: '小売') }
  let(:params_b) do
    {
        name: 'B',
        prefecture: '大阪府',
        city: '大阪市',
        house_number: '10',
        telephone_number: '09099999999',
        supplier_type_category: retail_supplier_type
    }
  end
  let(:create_supplier_b) { suppliers_repo.save(params_b) }

  let(:params_c) do
    {
        name: 'C',
        supplier_type_category: retail_supplier_type
    }
  end
  let(:create_supplier_c) { suppliers_repo.save(params_c) }


  describe '#create' do
    example '卸売取引先A' do
      create_supplier_a
      supplier = suppliers_repo.select_first

      expect(supplier.code).to eq 's0001'
      expect(supplier.name).to eq 'A'
      expect(supplier.prefecture).to eq '広島県'
      expect(supplier.city).to eq '広島市'
      expect(supplier.house_number).to eq '1'
      expect(supplier.telephone_number).to eq '090-9999-9999'
      expect(supplier.supplier_type_category.name).to eq '卸売'
    end

    example '小売取引先B' do
      create_supplier_b
      supplier = suppliers_repo.select_first

      expect(supplier.code).to eq 's0001'
      expect(supplier.name).to eq 'B'
      expect(supplier.prefecture).to eq '大阪府'
      expect(supplier.city).to eq '大阪市'
      expect(supplier.house_number).to eq '10'
      expect(supplier.telephone_number).to eq '090-9999-9999'
      expect(supplier.supplier_type_category.name).to eq '小売'
    end

    example '取引先ABC' do
      create_supplier_a
      create_supplier_b
      create_supplier_c

      expect(suppliers_repo.select_first.code).to eq 's0001'
      expect(suppliers_repo.select_second.code).to eq 's0002'
      expect(suppliers_repo.select_third.code).to eq 's0003'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
