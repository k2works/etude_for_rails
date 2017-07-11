class Baukis::ApplicationController <  ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include Baukis::ErrorHandlers if Rails.env.production?

  private
  def set_layout
    if params[:controller].match(%r{\A(baukis/staff|baukis/admin|baukis/customer)})
      Regexp.last_match[1].sub('/','_')
    else
      'baukis_customer'
    end
  end
end
