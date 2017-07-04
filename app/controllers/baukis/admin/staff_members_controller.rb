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

  def edit
    @staff_member = Baukis::StaffMember.find(params[:id])
  end

  def create
    @staff_member = Baukis::StaffMember.new(staff_member_params)
    if @staff_member.save
      flash.notice = '職員アカウントを新規登録しました。'
      redirect_to :baukis_admin_staff_members
    else
      render action: 'new'
    end
  end

  def update
    @staff_member = Baukis::StaffMember.find(params[:id])
    @staff_member.assign_attributes(staff_member_params)
    if @staff_member.save
      flash.notice = '職員アカウントを更新しました。'
      redirect_to :baukis_admin_staff_members
    else
      render action: 'edit'
    end
  end

  private
  def staff_member_params
    params.require(:baukis_staff_member).permit(
        :email,
        :password,
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :start_date,
        :end_date,
        :suspended
    )
  end
end
