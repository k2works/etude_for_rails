require 'test_helper'

class RailsTutorial::Sample::MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = rails_tutorial_sample_users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get rails_tutorial_sample_root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # 無効な送信
    assert_no_difference 'RailsTutorial::Sample::Micropost.count' do
      post rails_tutorial_sample_microposts_path, params: { rails_tutorial_sample_micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'

=begin
    #Jenkins Pipeline Dockerコンテナで動かない
    # 有効な送信
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails_tutorial/sample/rails.png', 'image/png')
    assert_difference 'RailsTutorial::Sample::Micropost.count', 1 do
      post rails_tutorial_sample_microposts_path, params: { rails_tutorial_sample_micropost: { content: content, picture: picture } }
    end
    assert assigns(:micropost).picture?
    assert_redirected_to rails_tutorial_sample_root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'RailsTutorial::Sample::Micropost.count', -1 do
      delete rails_tutorial_sample_micropost_path(first_micropost)
    end
=end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get rails_tutorial_sample_user_path(rails_tutorial_sample_users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
