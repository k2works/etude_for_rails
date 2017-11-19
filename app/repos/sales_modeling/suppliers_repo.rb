module SalesModeling
  class SuppliersRepo
    include ::SalesModeling::Purchase

    def new_supplier(params = {})
      params[:code] = (select_count + 1).to_s
      supplier = Supplier.new(params)
      setup_params(supplier)
      supplier
    end

    def save(params = {})
      supplier = new_supplier(params)
      supplier.save!
    end

    def update(code, params)
      supplier = select_by_code(code)
      setup_params(supplier)
      supplier.update!(params)
    end

    def select_count
      Supplier.count
    end

    def select_all
      Supplier.all
    end

    def select_first
      Supplier.first
    end

    def select_second
      Supplier.second
    end

    def select_third
      Supplier.third
    end

    def select_by_code(code)
      Supplier.where(code: code).first
    end

    def select_by_type(type)
      Supplier.where(supplier_type_category: type)
    end

    def destroy_by_code(code)
      select_by_code(code).destroy_all
    end

    private

    def setup_params(supplier)
      supplier.supplier_code = supplier.supplier_code
      supplier.address = supplier.address
      supplier.telephone = supplier.telephone
    end
  end
end
