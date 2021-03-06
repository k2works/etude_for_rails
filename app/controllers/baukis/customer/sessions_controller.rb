class Baukis::Customer::SessionsController < Baukis::Customer::Base
  skip_before_action :authorize

  def new
    if current_customer
      redirect_to :baukis_customer_root
    else
      @form = Baukis::Customer::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Baukis::Customer::LoginForm.new(session_params)
    if @form.email.present?
      customer = Baukis::Customer.find_by(email_for_index: @form.email.downcase)
    end
    if Baukis::Customer::Authenticator.new(customer).authenticate(@form.password)
      if @form.remember_me?
        cookies.permanent.signed[:customer_id] = customer.id
      else
        cookies.delete(:customer_id)
        session[:customer_id] = customer.id
      end
      flash.notice = 'ログインしました。'
      redirect_to :baukis_customer_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    cookies.delete(:customer_id)
    session.delete(:customer_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :baukis_customer_root
  end


  private
  def session_params
    params.require(:baukis_customer_login_form).permit(
        :email,
        :password,
        :remember_me
    )
  end
end
