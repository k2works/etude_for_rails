module SalesModeling
  module PurchaseDomain
    extend ActiveSupport::Concern

    included do
      def supplier_code=(supplier_code)
        self.code = supplier_code.code
      end

      def supplier_code
        @supplier_code ||= SalesModeling::Code::SupplierCode.new(code)
      end

      def address=(address)
        self.prefecture = address.prefecture
        self.city = address.city
        self.house_number = address.house_number
      end

      def address
        @address ||= SalesModeling::Address.new(prefecture, city, house_number)
      end

      def telephone=(telephone)
        self.telephone_number = telephone.number
      end

      def telephone
        @telephone ||= SalesModeling::Telephone.new(telephone_number)
      end
    end
  end
end