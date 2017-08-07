class RailsTutorial::ApplicationController <  ActionController::Base
  protect_from_forgery with: :exception
  include RailsTutorial::SessionsHelper
  layout :set_layout

  def hello
    render html: "hello, world!"
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to rails_tutorial_sample_login_url
    end
  end

  private
  def set_layout
    if params[:controller].match(%r{\A(rails_tutorial/toy|rails_tutorial/sample)})
      'rails_tutorial'
    end
  end
end
