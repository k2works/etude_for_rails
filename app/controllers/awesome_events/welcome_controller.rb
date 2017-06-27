class AwesomeEvents::WelcomeController < AwesomeEvents::ApplicationController
  PER = 10

  def index
    @events = AwesomeEvents::Event.page(params[:page]).per(PER).where('start_time > ?', Time.zone.now).order(:start_time)
  end
end
