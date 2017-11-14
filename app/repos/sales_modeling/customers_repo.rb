module SalesModeling
  class CustomersRepo
    include ::SalesModeling::Customer

    def new(params = {})
      self.customer_code = (select_count + 1).to_s
      setup_params(params)
      params[:customer_code] = @customer_code
      ::SalesModeling::Sales::Customer.new(params)
    end

    def save(customer)
      customer.save!
    end

    def update(customer, params)
      setup_params(params)
      customer.update!(params)
    end

    def select_count
      ::SalesModeling::Sales::Customer.count
    end

    def select_all
      ::SalesModeling::Sales::Customer.all
    end

    def select_first
      ::SalesModeling::Sales::Customer.first
    end

    def select_by_code(code)
      ::SalesModeling::Sales::Customer.where(code: code)
    end

    def select_by_customer_type(type)
      ::SalesModeling::Sales::Customer.where(customer_type_category: type)
    end

    def destroy_by_code(code)
      select_by_code(code).destroy_all
    end

    private

    def setup_params(params)
      self.name = params[:name]
      self.address = {prefecture: params[:prefecture], city: params[:city], house_number: params[:house_number]}
      self.telephone = params[:telephone_number]
      self.customer_type = params[:customer_type_category]
      params[:address] = @address
      params[:telephone] = @telephone
    end
  end
end
