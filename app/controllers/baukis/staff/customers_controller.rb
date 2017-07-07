class Baukis::Staff::CustomersController < Baukis::Staff::Base
  def index
    @customers = Baukis::Customer.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    @customer = Baukis::Customer.find(params[:id])
  end

  def new
    @customer_form = Baukis::Staff::CustomerForm.new
  end

  def edit
    @customer_form = Baukis::Staff::CustomerForm.new(Baukis::Customer.find(params[:id]))
  end
end
