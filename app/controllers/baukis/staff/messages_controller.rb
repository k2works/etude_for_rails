class Baukis::Staff::MessagesController < Baukis::Staff::Base
  # GET
  def count
    render text: Baukis::CustomerMessage.unprocessed.count
  end
end
