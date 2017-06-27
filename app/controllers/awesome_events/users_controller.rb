class AwesomeEvents::UsersController < AwesomeEvents::ApplicationController
  before_action :authenticate

  def retire
  end

  def destroy
    if current_user.destroy
      reset_session
      redirect_to awesome_events_welcome_index_path, notice: '退会完了しました'
    else
      render :retire
    end
  end
end
