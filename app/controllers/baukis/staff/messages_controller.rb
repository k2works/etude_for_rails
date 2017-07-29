class Baukis::Staff::MessagesController < Baukis::Staff::Base
  before_action :reject_non_xhr, only: [ :count ]
  # GET
  def count
    render plain: Baukis::CustomerMessage.unprocessed.count
  end
end
