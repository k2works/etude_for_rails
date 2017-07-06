class Baukis::Admin::StaffEventsController < Baukis::Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = Baukis::StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else
      @events = Baukis::StaffEvent.order(occurred_at: :desc)
    end
    @events = @events.includes(:member)
    @events = @events.page(params[:page])
  end
end
