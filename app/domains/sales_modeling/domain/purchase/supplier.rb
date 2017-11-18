module SalesModeling
  module Domain
    module Purchase
      module Supplier
        attr_reader :supplier_code,
                    :name,
                    :address,
                    :telephone,
                    :supplier_type

        def supplier_code=(code)
          @supplier_code = SalesModeling::Code::SupplierCode.new(code)
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

        def supplier_type=(params)
          @supplier_type = SalesModeling::Type::SupplierType.new(params[:code], params[:name]) unless params.nil?
        end
      end
    end
  end
end