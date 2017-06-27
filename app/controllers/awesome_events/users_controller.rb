class AwesomeEvents::UsersController < AwesomeEvents::ApplicationController
  before_action :authenticate

  def retire
  end

end
