class AwesomeEvents::TicketsController < AwesomeEvents::ApplicationController
  before_action :authenticate

  def new
    raise ActionController::RoutingError, 'ログイン状態で TicketController#newにアクセス'
  end

  def create
    ticket = current_user.tickets.build do |t|
      t.awesome_events_event_id = params[:event_id]
      t.comment = params[:awesome_events_ticket][:comment]
    end

    if ticket.save
      flash[:notice] = 'このイベントに参加表明しました'
      head 201
    else
      render json: { message: ticket.errors.full_messages }, status: 422
    end
  end
end
