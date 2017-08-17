require 'test_helper'

class RailsTutorial::Sample::RelationshipsControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged-in user" do
    assert_no_difference 'RailsTutorial::Sample::Relationship.count' do
      post rails_tutorial_sample_relationships_path
    end
    assert_redirected_to rails_tutorial_sample_login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'RailsTutorial::Sample::Relationship.count' do
      delete rails_tutorial_sample_relationship_path(rails_tutorial_sample_relationships(:one))
    end
    assert_redirected_to rails_tutorial_sample_login_url
  end
end
