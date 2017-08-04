# == Schema Information
#
# Table name: rails_tutorial_sample_users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RailsTutorial::Sample::UserTest < ActiveSupport::TestCase

  def setup
    @user = RailsTutorial::Sample::User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
