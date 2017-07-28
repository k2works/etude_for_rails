class Baukis::Customer::AccountsController < Baukis::Customer::Base
  def show
    @customer = current_customer
  end

  def edit
    @customer_form = Baukis::Customer::AccountForm.new(current_customer)
  end

  def update
    @customer_form = Baukis::Customer::AccountForm.new(current_customer)
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = 'アカウント情報を更新しました。'
      redirect_to :baukis_staff_account
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end
end
