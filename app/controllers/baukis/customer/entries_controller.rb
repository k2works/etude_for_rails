class Baukis::Customer::EntriesController < Baukis::Customer::Base
  def create
    program = Baukis::Program.published.find(params[:program_id])
    case Baukis::Customer::EntryAcceptor.new(current_customer).accept(program)
      when :accepted
        flash.notice = 'プログラムに申し込みました。'
      when :full
        flash.alert = 'プログラムへの申込者数が上限に達しました。'
      when :closed
        flash.alert = 'プログラムの申し込み期限が終了しました。'
    end
    redirect_to baukis_customer_program_url(program)
  end

  # PATCH
  def cancel
    program = Baukis::Program.published.find(params[:program_id])
    entry = program.entries.where(customer_id: current_customer.id).first!
    entry.update_column(:canceled, true)
    flash.notice = 'プログラムへの申込をキャンセルしました。'
    redirect_to baukis_customer_program_url(program)
  end
end
