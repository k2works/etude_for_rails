class Baukis::ApplicationController <  ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  rescue_from Exception, with: :rescue500
  rescue_from Forbidden, with: :rescure403
  rescue_from IpAddressRejected, with: :rescue403

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

  def rescue500(e)
    @exception = e
    render 'baukis/errors/internal_server_error', status: 500
  end
end
