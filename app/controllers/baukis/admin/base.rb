class Baukis::Admin::Base < Baukis::ApplicationController
  private
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
          Baukis::Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator
end