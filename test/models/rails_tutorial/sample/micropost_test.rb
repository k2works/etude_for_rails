# == Schema Information
#
# Table name: rails_tutorial_sample_microposts
#
#  id                            :integer          not null, primary key
#  content                       :text
#  rails_tutorial_sample_user_id :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

require 'test_helper'

class RailsTutorial::Sample::MicropostTest < ActiveSupport::TestCase

  def setup
    @user = rails_tutorial_sample_users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.rails_tutorial_sample_user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal rails_tutorial_sample_microposts(:most_recent), RailsTutorial::Sample::Micropost.first
  end
end
