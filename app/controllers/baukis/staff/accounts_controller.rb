class Baukis::Staff::AccountsController < Baukis::Staff::Base
  def show
    @staff_member = current_staff_member
  end

  def edit
    @staff_member = current_staff_member
  end
end
