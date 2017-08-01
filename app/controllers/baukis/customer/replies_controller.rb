class Baukis::Customer::RepliesController < Baukis::Customer::Base
  before_action :prepare_message

  def new
    @reply = Baukis::CustomerMessage.new
  end

  # POST
  def confirm
    @reply = Baukis::CustomerMessage.new(customer_message_params)
    if @reply.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def create
    @reply = Baukis::CustomerMessage.new(customer_message_params)
    if params[:commit]
      @reply.parent = @message
      if @reply.save
        flash.notice = 'メッセージに返信しました。'
        redirect_to :baukis_customer_messages
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
      render action:  'new'
    end
  end

  private
  def prepare_message
    @message = Baukis::StaffMessage.find(params[:message_id])
  end

  def customer_message_params
    params.require(:baukis_customer_message).permit(:subject, :body)
  end
end
