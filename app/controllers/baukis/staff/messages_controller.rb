class Baukis::Staff::MessagesController < Baukis::Staff::Base
  before_action :reject_non_xhr, only: [ :count ]
  protect_from_forgery :except => [:tag]

  def index
    @messages = Baukis::Message.where(deleted: false).page(params[:page])
    narrow_down
    @messages = @messages.page(params[:page])
  end

  # GET
  def inbound
    @messages = Baukis::CustomerMessage.where(deleted: false)
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  # GET
  def outbound
    @messages = Baukis::StaffMessage.where(deleted: false)
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  # GET
  def deleted
    @messages = Baukis::Message.where(deleted: true)
    narrow_down
    @messages = @messages.page(params[:page])
    render action: 'index'
  end

  # GET
  def count
    render plain: Baukis::CustomerMessage.unprocessed.count
  end

  def show
    @message = Baukis::Message.find(params[:id])
  end

  def destroy
    message = Baukis::CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = '問い合わせを削除しました。'
    redirect_back(fallback_location: baukis_staff_root_path)
  end

  # POST/DELETE
  def tag
    message = Baukis::CustomerMessage.find(params[:id])
    if request.post?
      message.add_tag(params[:label])
    elsif request.delete?
      message.remove_tag(params[:label])
    else
      raise
    end
    render plain: 'OK'
  end

  private
  def narrow_down
    if params[:tag_id]
      @messages = @messages.joins(:message_tag_links).where('baukis_message_tag_links.tag_id' => params[:tag_id])
    end
  end
end
