class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :twitter_logged_in?

  private

  def twitter_logged_in?
    !!session[:user_id]
  end
end
