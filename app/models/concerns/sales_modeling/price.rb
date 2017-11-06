module SalesModeling
  module Price
    extend ActiveSupport::Concern

    included do
      include Money
    end
  end
end