class Baukis::Staff::RepliesController < Baukis::Staff::Base
  before_action :prepare_message

  def new
    @reply = Baukis::StaffMessage.new
  end

  # POST
  def confirm
    @reply = Baukis::StaffMessage.new(staff_message_params)
    if @reply.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def create
    @reply = Baukis::StaffMessage.new(staff_message_params)
    if params[:commit]
      @reply.staff_member = current_staff_member
      @reply.parent = @message
      if @reply.save
        flash.notice = '問い合わせに返信しました。'
        redirect_to :outbound_baukis_staff_messages
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  private
  def prepare_message
    @message = Baukis::CustomerMessage.find(params[:message_id])
  end

  def staff_message_params
    params.require(:baukis_staff_message).permit(:subject, :body)
  end
end
