class Baukis::ApplicationController <  ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include Baukis::ErrorHandlers if Rails.env.production?
  rescue_from Baukis::ApplicationController::Forbidden, with: :rescue403
  rescue_from Baukis::ApplicationController::IpAddressRejected, with: :rescue403

  private
  def set_layout
    if params[:controller].match(%r{\A(baukis/staff|baukis/admin|baukis/customer)})
      Regexp.last_match[1].sub('/','_')
    else
      'baukis_customer'
    end
  end

  def rescue403(e)
    @exception = e
    render 'baukis/errors/forbidden', status: 403
  end

  def reject_non_xhr
    raise ActionController::BadRequest unless request.xhr?
  end
end
