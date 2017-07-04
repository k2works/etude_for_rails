class Baukis::Staff::Base < Baukis::ApplicationController
  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= Baukis::StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member
end