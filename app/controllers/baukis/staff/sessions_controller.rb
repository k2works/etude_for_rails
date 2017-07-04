class Baukis::Staff::SessionsController < Baukis::Staff::Base
  def new
    if current_staff_member
      redirect_to :baukis_staff_root
    else
      @form = Baukis::Staff::LoginForm.new
      render action: 'new'
    end
  end
end
