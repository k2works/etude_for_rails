module RailsTutorial
  module SessionsHelper
    # 渡されたユーザーでログインする
    def log_in(user)
      session[:rails_tutorial_sample_user_id] = user.id
    end

    # ユーザーを永続的セッションに記憶する
    def remember(user)
      user.remember
      cookies.permanent.signed[:rails_tutorial_sample_user_id] = user.id
      cookies.permanent[:rails_tutorial_sample_remember_token] = user.remember_token
    end

    # 渡されたユーザーがログイン済みユーザーであればtrueを返す
    def current_user?(user)
      user == current_user
    end

    # 記憶トークンcookieに対応するユーザーを返す
    def current_user
      if (user_id = session[:rails_tutorial_sample_user_id])
        @current_user ||= RailsTutorial::Sample::User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:rails_tutorial_sample_user_id])
        user = RailsTutorial::Sample::User.find_by(id: user_id)
        if user && user.authenticated?(:remember,cookies[:rails_tutorial_sample_remember_token])
          log_in user
          @current_user = user
        end
      end
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
      !current_user.nil?
    end

    # 永続的セッションを破棄する
    def forget(user)
      user.forget
      cookies.delete(:rails_tutorial_sample_user_id)
      cookies.delete(:rails_tutorial_sample_remember_token)
    end

    # 現在のユーザーをログアウトする
    def log_out
      forget(current_user)
      session.delete(:rails_tutorial_sample_user_id)
      @current_user = nil
    end

    # 記憶したURL (もしくはデフォルト値) にリダイレクト
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    # アクセスしようとしたURLを覚えておく
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  end
end