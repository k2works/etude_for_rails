class AwesomeEvents::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'awesome_events'

  helper_method :current_user,:logged_in?

  rescue_from Exception, with: :error500 if Rails.env == 'Production'
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

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

  def error404(e)
    render 'error404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("¥n")
    render 'error500', status: 500, formats: [:html]
  end
end
