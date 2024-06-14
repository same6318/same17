class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]#アカウント登録の時にはログイン要求は無し。
    before_action :correct_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in(@user) #アカウント登録と同時にログイン
            flash[:notice] = "アカウントを登録しました"
            redirect_to tasks_path
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @user.update(user_params)
            log_in(@user)
            flash[:notice] = "アカウントを更新しました"
            redirect_to user_path
        else
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            #binding.irb
        flash[:notice] = "ログインしてください"
        end
        redirect_to current_user unless current_user?(@user)
    end #データベースのユーザーidをcurrent_user?メソッドに引き渡して、アクセス先のidと照合している。

end
