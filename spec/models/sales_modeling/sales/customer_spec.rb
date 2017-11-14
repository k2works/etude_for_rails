# frozen_string_literal: true

require 'rails_helper'
include SalesModeling::Sales

RSpec.describe SalesModeling::Sales::Customer, type: :model do
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:special_type) { create(:customer_type_category, name: '特別') }
  let(:params_a) {
    {:code => '1',
     :name => 'A',
     :prefecture => '広島県',
     :city => '広島市',
     :house_number => '1-1-1',
     :telephone_number => '09099999999',
     :customer_type_category => normal_type
    }
  }
  let(:params_b) {
    {:code => '2',
     :name => 'B',
     :prefecture => '広島県',
     :city => '広島市',
     :house_number => '1-1-1',
     :telephone_number => '09099999999',
     :customer_type_category => special_type
    }
  }
  let(:params_c) {
    {:code => '3',
     :name => 'C',
     :prefecture => '兵庫県',
     :city => '西宮市',
     :house_number => '9-9-9',
     :telephone_number => '000-0000-0000',
     :customer_type_category => special_type
    }
  }
  let(:customers_repo) { SalesModeling::CustomersRepo.new }
  let(:customer_a) { customers_repo.new(params_a) }
  let(:customer_b) { customers_repo.new(params_b) }
  let(:customer_c) { customers_repo.new(params_c) }
  let(:create_customer_a) { customers_repo.save(customer_a) }
  let(:create_customer_b) { customers_repo.save(customer_b) }
  let(:create_customer_c) { customers_repo.save(customer_c) }
  let(:select_all) { customers_repo.select_all }
  let(:select_first) { customers_repo.select_first }
  let(:select_customer_a_by_code) { customers_repo.select_by_code(customer_a.code) }
  let(:select_customer_b_by_code) { customers_repo.select_by_code(customer_b.code) }
  let(:select_customer_c_by_code) { customers_repo.select_by_code(customer_c.code) }
  let(:select_special_customer) { customers_repo.select_by_customer_type(special_type) }
  let(:delete_customer_a) { customers_repo.destroy_by_code(customer_a.code) }
  let(:delete_customer_b) { customers_repo.destroy_by_code(customer_b.code) }
  let(:delete_customer_c) { customers_repo.destroy_by_code(customer_c.code) }

  describe '#create' do
    example '顧客A 住所:広島県広島市西区1-1-1 電話番号:090-9999-9999 顧客区分:一般' do
      create_customer_a
      customer = select_first
      params = params_a
      expect(customer.code).to eq 'c0001'
      expect(customer.name).to eq(params[:name])
      expect(customer.prefecture).to eq(params[:prefecture])
      expect(customer.city).to eq(params[:city])
      expect(customer.house_number).to eq(params[:house_number])
      expect(customer.telephone_number).to eq '090-9999-9999'
      expect(customer.customer_type_category.name).to eq(params[:customer_type_category].name)
    end
    example '顧客B 住所:広島県広島市西区1-1-1 電話番号:090-999-9999 顧客区分:特別' do
      create_customer_b
      customer = select_first
      expect(customer.customer_type_category.name).to eq('特別')
    end
    example '顧客C 住所:兵庫県西宮市9-9-9 電話番号:000-000-0000 顧客区分:一般' do
      create_customer_c
      customer = select_first
      params = params_a
      expect(customer.code).not_to eq(params[:code])
      expect(customer.name).not_to eq(params[:name])
      expect(customer.prefecture).not_to eq(params[:prefecture])
      expect(customer.city).not_to eq(params[:city])
      expect(customer.house_number).not_to eq(params[:house_number])
      expect(customer.telephone_number).not_to eq(params[:telephone_number])
      expect(customer.customer_type_category.name).not_to eq(params[:customer_type_category].name)
    end
  end

  describe '#select' do
    before(:each) do
      create_customer_a
      create_customer_b
      create_customer_c
    end

    example '総数' do
      expect(select_all.count).to eq 3
    end

    example '顧客A' do
      expect(select_customer_a_by_code.count).to eq 1
    end

    example '顧客B' do
      expect(select_customer_b_by_code.count).to eq 1
    end

    example '特別顧客区分' do
      expect(select_special_customer.count).to eq 2
    end
  end

  describe '#update' do
    before(:each) do
      create_customer_a
      create_customer_b
      create_customer_c
    end

    example '顧客Aの顧客区分更新' do
      customer = select_customer_a_by_code.first
      customer.customer_type_category = special_type
      customers_repo.save(customer)
      expect(select_all.first.customer_type_category.name).to eq('特別')
    end

    example '顧客Aを顧客Bに更新' do
      customer = select_customer_a_by_code.first
      customers_repo.update(customer, params_b)
      expect(select_customer_b_by_code.count).to eq 2
    end

    example '顧客Cの電話番号を更新' do
      customer = select_customer_c_by_code.first
      params = params_c
      params[:telephone_number] = '09033334444'
      customers_repo.update(customer, params)
      expect(select_customer_c_by_code.first.telephone_number).to eq '090-3333-4444'
    end
  end

  describe '#delete' do
    before(:each) do
      create_customer_a
      create_customer_b
      create_customer_c
    end

    example '全件削除' do
      select_all.destroy_all
      expect(select_all.count).to eq 0
    end

    example '全件削除' do
      select_all.delete_all
      expect(select_all.count).to eq 0
    end

    example '顧客Aを削除' do
      delete_customer_a
      expect(select_all.count).to eq 2
    end

    example '顧客B,Cを削除' do
      delete_customer_b
      delete_customer_c
      expect(select_all.count).to eq 1
      expect(select_customer_a_by_code.count).to eq 1
      expect(select_customer_b_by_code.count).to eq 0
      expect(select_customer_c_by_code.count).to eq 0
    end
  end
end
