class HtmlCssBook::CampaignController < ApplicationController
  def index
  end

  def submit
    redirect_to html_css_book_campaign_index_path
  end
end
