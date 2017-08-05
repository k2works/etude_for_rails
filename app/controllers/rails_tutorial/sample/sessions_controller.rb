class RailsTutorial::Sample::SessionsController < RailsTutorial::ApplicationController
  def new
  end

  def create
    user = RailsTutorial::Sample::User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to rails_tutorial_sample_root_url
  end
end
