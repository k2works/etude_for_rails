class RailsTutorial::Sample::UsersController < RailsTutorial::ApplicationController
  def show
    @user = RailsTutorial::Sample::User.find(params[:id])
  end

  def new
    @user = RailsTutorial::Sample::User.new
  end

  def create
    @user = RailsTutorial::Sample::User.new(params[:rails_tutorial_sample_user])
    if @user.save
    else
      render 'new'
    end
  end
end
