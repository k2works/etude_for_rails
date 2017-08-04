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

class RailsTutorial::Sample::UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get rails_tutorial_sample_signup_url
    assert_response :success
  end
end
