class RailsTutorial::ApplicationController <  ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

  private
  def set_layout
    if params[:controller].match(%r{\A(rails_tutorial/toy|rails_tutorial/sample)})
      'rails_tutorial'
    end
  end
end
