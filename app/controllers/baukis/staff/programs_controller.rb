class Baukis::Staff::ProgramsController < Baukis::Staff::Base
  def index
    @programs = Baukis::Program.order(application_start_time: :desc).listing.page(params[:page])
  end

  def show
    @program = Baukis::Program.listing.find(params[:id])
  end
end
