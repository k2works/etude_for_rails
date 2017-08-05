class RailsTutorial::Sample::UsersController < RailsTutorial::ApplicationController
  def show
    @user = RailsTutorial::Sample::User.find(params[:id])
  end

  def new
    @user = RailsTutorial::Sample::User.new
  end

  def create
    @user = RailsTutorial::Sample::User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = RailsTutorial::Sample::User.find(params[:id])
  end

  private

  def user_params
    params.require(:rails_tutorial_sample_user).permit(:name, :email, :password, :password_confirmation)
  end
end
