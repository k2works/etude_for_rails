class Baukis::Staff::TopController < ApplicationController
  layout 'baukis'

  def index
    render action: 'index'
  end
end
