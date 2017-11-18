module SalesModeling
  class SuppliersRepo
    include ::SalesModeling::Domain::Purchase::Supplier

    def new_supplier(params = {})
      self.supplier_code = (select_count + 1).to_s
      setup_params(params)
      params[:supplier_code] = @supplier_code
      ::SalesModeling::Purchase::Supplier.new(params)
    end

    def save(params = {})
      setup_params(params)
      supplier = new_supplier(params)
      supplier.save!
    end

    def update(code, params)
      setup_params(params)
      supplier = select_by_code(code)
      supplier.update!(params)
    end

    def select_count
      ::SalesModeling::Purchase::Supplier.count
    end

    def select_all
      ::SalesModeling::Purchase::Supplier.all
    end

    def select_first
      ::SalesModeling::Purchase::Supplier.first
    end

    def select_second
      ::SalesModeling::Purchase::Supplier.second
    end

    def select_third
      ::SalesModeling::Purchase::Supplier.third
    end

    def select_by_code(code)
      ::SalesModeling::Purchase::Supplier.where(code: code).first
    end

    def select_by_type(type)
      ::SalesModeling::Purchase::Supplier.where(supplier_type_category: type)
    end

    def destroy_by_code(code)
      select_by_code(code).destroy_all
    end

    private

    def setup_params(params)
      self.name = params[:name]
      self.address = {prefecture: params[:prefecture], city: params[:city], house_number: params[:house_number]}
      self.telephone = params[:telephone_number]
      self.supplier_type = params[:supplier_type_category]
      params[:address] = @address
      params[:telephone] = @telephone
    end
  end
end
