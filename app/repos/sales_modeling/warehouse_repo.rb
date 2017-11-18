# frozen_string_literal: true

module SalesModeling
  class WarehouseRepo
    def new_warehouse(params = {})
      SalesModeling::Purchase::Warehouse.new(params)
    end

    def save(params = {})
      warehouse = new_warehouse(params)
      warehouse.save!
    end

    def select_first
      SalesModeling::Purchase::Warehouse.first
    end
  end
end
