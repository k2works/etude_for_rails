class Baukis::Staff::ProgramsController < Baukis::Staff::Base
  def index
    @programs = Baukis::Program.order(application_start_time: :desc).listing.page(params[:page])
  end

  def show
    @program = Baukis::Program.listing.find(params[:id])
  end

  def new
    @program_form = Baukis::Staff::ProgramForm.new
  end

  def edit
    @program_form = Baukis::Staff::ProgramForm.new(Baukis::Program.find(params[:id]))
  end

  def create
    @program_form = Baukis::Staff::ProgramForm.new
    @program_form.assign_attributes(params[:form])
    @program_form.program.registrant = current_staff_member
    if @program_form.save
      flash.notice = 'プログラムを登録しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def update
    @program_form = Baukis::Staff::ProgramForm.new(Baukis::Program.find(params[:id]))
    @program_form.assign_attributes(params[:form])
    if @program_form.save
      flash.notice = 'プログラムを更新しました。'
      redirect_to action: 'index'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def destroy
    program = Baukis::Program.find(params[:id])
    if program.deletable?
      program.destroy!
      flash.notice = 'プログラムを削除しました。'
    else
      flash.alert = 'このプログラムは削除できません。'
    end
    redirect_to :baukis_staff_programs
  end

  # PATCH
  def entries
    entries_form = Baukis::Staff::EntriesForm.new(Baukis::Program.find(params[:id]))
    entries_form.assign_attributes(params[:form])
    entries_form.save
    flash.notice = 'プログラム申し込みフラグを更新しました。'
    redirect_to :baukis_staff_programs
  end
end
