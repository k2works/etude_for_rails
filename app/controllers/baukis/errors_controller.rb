class Baukis::ErrorsController < Baukis::ApplicationController
  def routing_error
    raise ActionController::RoutingError,
          "No route matcheds #{request.path.inspect}"
  end
end
