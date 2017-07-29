class Baukis::Staff::MessagesController < Baukis::Staff::Base
  # GET
  def count
    render plain: Baukis::CustomerMessage.unprocessed.count
  end
end
