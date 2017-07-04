class Baukis::Staff::TopController < Baukis::Staff::Base
  def index
    render action: 'index'
  end
end
