class Baukis::Staff::CustomersController < Baukis::Staff::Base
  def index
    if params[:search].nil?
      @search_form = Baukis::Staff::CustomerSearchForm.new
    else
      @search_form = Baukis::Staff::CustomerSearchForm.new(params)
    end
    @customers = @search_form.search.page(params[:page])
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

  def create
    @customer_form = Baukis::Staff::CustomerForm.new
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客を追加しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def update
    @customer_form = Baukis::Staff::CustomerForm.new(Baukis::Customer.find(params[:id]))
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客情報を更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def destroy
    customer = Baukis::Customer.find(params[:id])
    customer.destroy!
    flash.notice = '顧客アカウントを削除しました。'
    redirect_to :baukis_staff_customers
  end

end
