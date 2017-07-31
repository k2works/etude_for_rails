class Baukis::Staff::RepliesController < Baukis::Staff::Base
  before_action :prepare_message

  def new
    @reply = Baukis::StaffMessage.new
  end

  private
  def prepare_message
    @message = Baukis::CustomerMessage.find(params[:message_id])
  end
end
