class Baukis::Customer::AccountsController < Baukis::Customer::Base
  def show
    @customer = current_customer
  end
end
