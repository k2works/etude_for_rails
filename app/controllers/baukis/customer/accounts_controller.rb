class Baukis::Customer::AccountsController < Baukis::Customer::Base
  def show
    @customer = current_customer
  end

  def edit
    @customer_form = Baukis::Customer::AccountForm.new(current_customer)
  end

  # PATCH
  def confirm
    @customer_form = Baukis::Customer::AccountForm.new(current_customer)
    @customer_form.assign_attributes(params[:form])
    if @customer_form.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def update
    @customer_form = Baukis::Customer::AccountForm.new(current_customer)
    update_address_option
    @customer_form.assign_attributes(params[:form])
    if params[:commit]
      if @customer_form.save
        flash.notice = 'アカウント情報を更新しました。'
        redirect_to :baukis_customer_account
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'edit'
      end
    else
      render action: 'edit'
    end
  end

  private
  def update_address_option
    params.require(:form).permit(
        :inputs_home_address,
        :inputs_work_address
    )
    params[:form][:inputs_home_address] = '1' if params[:form][:inputs_home_address]
    params[:form][:inputs_work_address] = '1' if params[:form][:inputs_work_address]
  end
end
