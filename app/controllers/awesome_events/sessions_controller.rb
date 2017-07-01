class AwesomeEvents::SessionsController < AwesomeEvents::ApplicationController
  def create
    user = AwesomeEvents::User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:awesome_events_user_id] = user.id
    redirect_to awesome_events_welcome_index_path, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to awesome_events_welcome_index_path, notice: 'ログアウトしました'
  end
end
