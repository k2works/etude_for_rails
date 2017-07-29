class Baukis::Staff::MessagesController < Baukis::Staff::Base
  before_action :reject_non_xhr, only: [ :count ]

  def index
    @messages = Baukis::Message.where(deleted: false).page(params[:page])
  end

  # GET
  def inbound
    @messages = Baukis::CustomerMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  # GET
  def outbound
    @messages = Baukis::StaffMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  # GET
  def deleted
    @messages = Baukis::Message.where(deleted: true).page(params[:page])
    render action: 'index'
  end

  # GET
  def count
    render plain: Baukis::CustomerMessage.unprocessed.count
  end
end
