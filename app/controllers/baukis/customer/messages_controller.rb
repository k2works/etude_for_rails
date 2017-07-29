class Baukis::Customer::MessagesController < Baukis::Customer::Base
  def new
    @message = Baukis::CustomerMessage.new
  end

  # POST
  def confirm
    @message = Baukis::CustomerMessage.new(customer_message_params)
    @message.customer = current_customer
    if @message.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def create
    @message = Baukis::CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = '問い合わせを送信しました。'
        redirect_to :baukis_customer_root
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  private
  def customer_message_params
    params.require(:baukis_customer_message).permit(:subject, :body)
  end
end
