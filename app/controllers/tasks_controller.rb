class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  # skip_before_action :login_required, only: [:new, :create] #タスク登録の時にログイン要求は無し。
  before_action :correct_user, only: [:new, :create, :show, :edit, :update, :destroy] #登録、一覧、編集の時にはログイン状態でなければならない。

  def index
    @tasks = current_user.tasks
    # binding.irb
  end

  def new
    @task = Task.new #ここはインスタンスの作成のみ
  end

  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.create(task_params)
    #@task.user_id = current_user.id
    #binding.irb
    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @task.user_id = current_user.id
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

  def set_task
    @task = Task.find(params[:id])
    #binding.irb
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end

  def correct_user
    @user = current_user
    #binding.irb
    # @user = @task.user
    # unless current_user?(@user)
    # flash[:notice] = "ログインしてください"
    # end
    redirect_to current_user unless current_user?(@user)
    #別のアカウントのアクセス先に入ろうとしたら、リダイレクトさせる。
  end #データベースのユーザーidをcurrent_user?メソッドに引き渡して、アクセス先のidと照合している。  

end
