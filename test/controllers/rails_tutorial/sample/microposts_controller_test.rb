require 'test_helper'

class RailsTutorial::Sample::MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = rails_tutorial_sample_microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'RailsTutorial::Sample::Micropost.count' do
      post rails_tutorial_sample_microposts_path, params: { rails_tutorial_sample_micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'RailsTutorial::Sample::Micropost.count' do
      delete rails_tutorial_sample_micropost_path(@micropost)
    end
    assert_redirected_to rails_tutorial_sample_login_url
  end
end
