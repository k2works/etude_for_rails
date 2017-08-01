require "rails_helper"

RSpec.describe RailsTutorial::Toy::UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rails_tutorial/toys").to route_to("rails_tutorial/toys#index")
    end

    it "routes to #new" do
      expect(:get => "/rails_tutorial/toys/new").to route_to("rails_tutorial/toys#new")
    end

    it "routes to #show" do
      expect(:get => "/rails_tutorial/toys/1").to route_to("rails_tutorial/toys#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rails_tutorial/toys/1/edit").to route_to("rails_tutorial/toys#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rails_tutorial/toys").to route_to("rails_tutorial/toys#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rails_tutorial/toys/1").to route_to("rails_tutorial/toys#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rails_tutorial/toys/1").to route_to("rails_tutorial/toys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rails_tutorial/toys/1").to route_to("rails_tutorial/toys#destroy", :id => "1")
    end

  end
end
