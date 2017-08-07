class RailsTutorial::Sample::MicropostsController < RailsTutorial::ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to rails_tutorial_sample_root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    params.require(:micropost).permit(:content)
  end
end
