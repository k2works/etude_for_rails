class Baukis::Admin::StaffMembersController < Baukis::Admin::Base
  def index
    @staff_members = Baukis::StaffMember.order(:family_name_kana, :given_name_kana)
  end
end
