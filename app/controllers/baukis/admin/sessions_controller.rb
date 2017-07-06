class Baukis::Admin::SessionsController < Baukis::Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Baukis::Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Baukis::Admin::LoginForm.new(session_params)
    if @form.email.present?
      administrator = Baukis::Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Baukis::Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[:administrator_id] = administrator.id
        session[:last_access_time] = Time.zone.now
        flash.notice = 'ログインしました'
        redirect_to :baukis_admin_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :baukis_admin_root
  end

  private
  def session_params
    params.require(:baukis_admin_login_form).permit(
        :email,
        :password
    )
  end
end
