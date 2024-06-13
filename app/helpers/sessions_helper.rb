module SessionsHelper

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in? #ログインされているかの確認
        current_user.present?
    end

    def log_in(user) #ログインユーザーをユーザーに入れるメソッド
        session[:user_id] = user.id
    end

    def current_user?(user) #ログインしているアカウント（引数）が現在のアカウントであること（current_user)を照合
        user == current_user
    end

end
