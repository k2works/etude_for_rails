require 'test_helper'

class RailsTutorial::SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get rails_tutorial_sample_root_path
    assert_template 'rails_tutorial/sample/static_pages/home'
    assert_select "a[href=?]", rails_tutorial_sample_root_path, count: 2
    assert_select "a[href=?]", rails_tutorial_sample_help_path
    assert_select "a[href=?]", rails_tutorial_sample_about_path
    assert_select "a[href=?]", rails_tutorial_sample_contact_path
    get rails_tutorial_sample_contact_path
    assert_select "title", full_title("(test) Contact")
    get rails_tutorial_sample_signup_path
    assert_select "title", full_title("(test) Sign up")
  end
end