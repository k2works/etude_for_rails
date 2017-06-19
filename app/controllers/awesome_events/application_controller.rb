class AwesomeEvents::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'awesome_events'

  helper_method :current_user,:logged_in?

  private

  def current_user
    return unless session[:awesome_events_user_id]
    @current_user ||= AwesomeEvents::User.find(session[:awesome_events_user_id])
  end

  def logged_in?
    !!session[:awesome_events_user_id]
  end

  def authenticate
    return if logged_in?
    redirect_to awesome_events_welcome_index_path, alert:'ログインしてください'
  end
end
