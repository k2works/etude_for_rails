module SalesModeling
  module Customer
    attr_reader :customer_code,
                :name,
                :address,
                :telephone,
                :customer_type

    def customer_code=(code)
      @customer_code = SalesModeling::Code::CustomerCode.new(code)
    end

    def name=(name)
      @name = name
    end

    def address=(params)
      @address = SalesModeling::Address.new(params[:prefecture], params[:city], params[:house_number]) unless params.nil?
    end

    def telephone=(number)
      @telephone = SalesModeling::Telephone.new(number)
    end

    def customer_type=(params)
      @customer_type = SalesModeling::Type::CustomerType.new(params[:code], params[:name]) unless params.nil?
    end
  end
end