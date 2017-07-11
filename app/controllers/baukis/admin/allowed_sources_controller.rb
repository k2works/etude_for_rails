class Baukis::Admin::AllowedSourcesController < Baukis::Admin::Base
  def index
    @allowed_sources = Baukis::AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
    @new_allowed_source = Baukis::AllowedSource.new
  end

  def create
    @new_allowed_source = Baukis::AllowedSource.new(allowed_source_params)
    @new_allowed_source.namespace = 'staff'
    if @new_allowed_source.save
      flash.notice = '許可IPアドレスを追加しました。'
      redirect_to action: 'index'
    else
      @allowed_sources = Baukis::AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
      flash.now.alert = '許可IPアドレスの値が正しくありません。'
      render action: 'index'
    end
  end

  private
  def allowed_source_params
    params.require(:baukis_allowed_source).permit(:octet1, :octet2, :octet3, :last_octet)
  end
end