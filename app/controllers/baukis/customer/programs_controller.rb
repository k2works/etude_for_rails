class Baukis::Customer::ProgramsController < Baukis::Customer::Base
  def index
    @programs = Baukis::Program.published.page(params[:page])
  end

  def show
    @program = Baukis::Program.published.find(params[:id])
  end
end
