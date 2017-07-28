class Baukis::Customer::EntriesController < Baukis::Customer::Base
  def create
    program = Baukis::Program.published.find(params[:program_id])
    case Baukis::Customer::EntryAcceptor.new(current_customer).accept(program)
      when :accepted
        flash.notice = 'プログラムに申し込みました。'
      when :full
        flash.alert = 'プログラムへの申込者数が上限に達しました。'
    end
    redirect_to :baukis_customer_programs
  end
end
