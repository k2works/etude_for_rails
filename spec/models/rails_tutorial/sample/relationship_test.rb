require 'test_helper'

class RailsTutorial::Sample::RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = RailsTutorial::Sample::Relationship.new(follower_id: rails_tutorial_sample_users(:michael).id,
                                                            followed_id: rails_tutorial_sample_users(:archer).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
