class Baukis::Customer::MessagesController < Baukis::Customer::Base
  def new
    @message = Baukis::CustomerMessage.new
  end
end
