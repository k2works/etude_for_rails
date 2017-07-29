module Baukis::ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::BadRequest, with: :rescue400
    rescue_from ActionController::ParameterMissing, with: :rescue400
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end
end

private
def rescue400(e)
  @exception = e
  render 'baukis/errors/bad_request', status: 400
end

def rescue404(e)
  @exception = e
  render 'baukis/errors/not_found', status: 404
end

def rescue500(e)
  @exception = e
  render 'baukis/errors/internal_server_error', status: 500
end