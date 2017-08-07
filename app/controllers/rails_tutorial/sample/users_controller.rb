class RailsTutorial::Sample::UsersController < RailsTutorial::ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = RailsTutorial::Sample::User.paginate(page:params[:page])
  end

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
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    RailsTutorial::Sample::User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to rails_tutorial_sample_users_url
  end

  private

  def user_params
    params.require(:rails_tutorial_sample_user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to rails_tutorial_sample_login_url
    end
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = RailsTutorial::Sample::User.find(params[:id])
    redirect_to(rails_tutorial_sample_root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(rails_tutorial_sample_root_url) unless current_user.admin?
  end
end
