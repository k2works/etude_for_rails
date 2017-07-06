class Baukis::Staff::PasswordsController < Baukis::Staff::Base
  def show
    redirect_to :edit_baukis_staff_password
  end

  def edit
    @change_password_form = Baukis::Staff::ChangePasswordForm.new(object: current_staff_member)
  end
end
