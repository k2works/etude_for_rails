class Baukis::Staff::PasswordsController < Baukis::Staff::Base
  def show
    redirect_to :edit_baukis_staff_password
  end
end
