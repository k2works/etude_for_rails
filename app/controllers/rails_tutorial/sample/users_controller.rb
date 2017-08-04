class RailsTutorial::Sample::UsersController < RailsTutorial::ApplicationController
  def show
    @user = RailsTutorial::Sample::User.find(params[:id])
  end

  def new
    @user = RailsTutorial::Sample::User.new
  end
end
