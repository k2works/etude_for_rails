class Baukis::Staff::SessionsController < Baukis::Staff::Base
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
      session[:staff_member_id] = staff_member.id
      redirect_to :baukis_staff_root
    else
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
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
