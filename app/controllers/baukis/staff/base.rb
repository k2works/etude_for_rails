class Baukis::Staff::Base < Baukis::ApplicationController
  before_action :authorize

  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= Baukis::StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member

  def authorize
    unless current_staff_member
      flash.alert = '職員としてログインしてください。'
      redirect_to :baukis_staff_login
    end
  end
end