class AwesomeEvents::WelcomeController < AwesomeEvents::ApplicationController
  def index
    @events = AwesomeEvents::Event.where('start_time > ?', Time.zone.now).order(:start_time)
  end
end
