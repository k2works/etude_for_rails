class Baukis::Admin::AllowedSourcesController < Baukis::Admin::Base
  def index
    @allowed_sources = Baukis::AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
  end
end