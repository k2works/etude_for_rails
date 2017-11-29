# frozen_string_literal: true

module SalesModeling
  class WarehouseRepo
    def new_warehouse(params = {})
      warehouse = SalesModeling::Purchase::Warehouse.new(params)
      unless warehouse.sales_modeling_purchase_stock.nil?
        unless warehouse.sales_modeling_purchase_stock.sales_modeling_purchase_order.nil?
          warehouse.sales_modeling_purchase_order = warehouse.sales_modeling_purchase_stock.sales_modeling_purchase_order
        end
      end
      warehouse
    end

    def save_warehouse(warehouse)
      warehouse.save! unless warehouse.nil?
    end

    def save(params = {})
      warehouse = new_warehouse(params)
      warehouse.save!
    end

    def select_all
      SalesModeling::Purchase::Warehouse.all
    end

    def select_first
      SalesModeling::Purchase::Warehouse.first
    end

    def select_second
      SalesModeling::Purchase::Warehouse.second
    end

    def select_third
      SalesModeling::Purchase::Warehouse.third
    end
  end
end
