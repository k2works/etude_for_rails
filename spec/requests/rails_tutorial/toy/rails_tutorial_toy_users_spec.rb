require 'rails_helper'

RSpec.describe "RailsTutorial::Toy::Users", type: :request do
  describe "GET /rails_tutorial_toy_users" do
    it "works! (now write some real specs)" do
      get rails_tutorial_toy_users_path
      expect(response).to have_http_status(200)
    end
  end
end
