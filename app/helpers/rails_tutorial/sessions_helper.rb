module RailsTutorial
  module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
      session[:rails_tutorial_sample_user_id] = user.id
    end
    # 現在ログイン中のユーザーを返す (いる場合)
    def current_user
      @current_user ||= RailsTutorial::Sample::User.find_by(id: session[:rails_tutorial_sample_user_id])
    end
  end
end