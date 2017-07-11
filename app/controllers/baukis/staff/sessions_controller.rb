class Baukis::Staff::SessionsController < Baukis::Staff::Base
  skip_before_action :authorize

  def new
    if current_staff_member
      redirect_to :baukis_staff_root
    else
      @form = Baukis::Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Baukis::Staff::LoginForm.new(session_params)
    if @form.email.present?
      staff_member = Baukis::StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Baukis::Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        staff_member.events.create!(event_type: 'rejected')
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[:staff_member_id] = staff_member.id
        session[:last_access_time] = Time.zone.now
        staff_member.events.create!(event_type: 'logged_in')
        flash.notice = 'ログインしました。'
        redirect_to :baukis_staff_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    if current_staff_member
      current_staff_member.events.create!(event_type: 'loged_out')
    end
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :baukis_staff_root
  end

  private
  def session_params
    params.require(:baukis_staff_login_form).permit(
        :email,
        :password
    )
  end
end
