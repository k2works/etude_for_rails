module SalesModeling
  class CustomersRepo
    def select_all
      Customer.all
    end

    def select_first
      Customer.first
    end

    def select_by_code(code)
      Customer.where(code: code)
    end

    def select_by_customer_type(type)
      Customer.where(customer_type_category: type)
    end

    def destroy_by_code(code)
      select_by_code(code).destroy_all
    end
  end
end
