class Baukis::Admin::StaffMembersController < Baukis::Admin::Base
  def index
    @staff_members = Baukis::StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def show
    staff_member = Baukis::StaffMember.find(params[:id])
    redirect_to edit_baukis_admin_staff_member_url(staff_member)
  end

  def new
    @staff_member = Baukis::StaffMember.new
  end
end
