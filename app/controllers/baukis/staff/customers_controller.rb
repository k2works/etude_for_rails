class Baukis::Staff::CustomersController < Baukis::Staff::Base
  def index
    @customers = Baukis::Customer.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    @customer = Baukis::Customer.find(params[:id])
  end
end
