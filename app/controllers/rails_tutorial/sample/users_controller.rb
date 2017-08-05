class RailsTutorial::Sample::UsersController < RailsTutorial::ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

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

  def update
    @user = RailsTutorial::Sample::User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:rails_tutorial_sample_user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to rails_tutorial_sample_login_url
    end
  end
end
