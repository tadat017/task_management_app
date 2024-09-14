class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]

  # タスク一覧表示
  def index
    # 優先度フィルタ
    @tasks = Task.all
    if params[:priority].present?
      @tasks = @tasks.where(priority: params[:priority])
    end
  
    # 完了/未完了のフィルタ
    if params[:completed] == 'true'
      @tasks = @tasks.where(completed: true)
    else
      @tasks = @tasks.where(completed: false)
    end
  
    # 期限切れタスクのフィルタ
    if params[:expired] == 'true'
      @tasks = @tasks.where('deadline < ?', Time.current)
    else
      @tasks = @tasks.where('deadline >= ? OR deadline IS NULL', Time.current)
    end
  
    @tasks = @tasks.order(priority: :desc, deadline: :asc)
  end
  
  
  # 新しいタスク作成フォーム表示
  def new
    @task = Task.new
  end

  # タスクの作成
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが作成されました。'
    else
      render :new
    end
  end

  # タスク編集フォーム表示
  def edit
  end

  # タスクの更新
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが更新されました。'
    else
      render :edit
    end
  end

  # タスクの削除
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクが削除されました。'
  end

  def show
    @task = Task.find(params[:id])
  end

  # タスクの完了状態をトグル
  def toggle_complete
    @task.update(completed: !@task.completed)
    redirect_to tasks_path, notice: 'タスクの状態が更新されました。'
  end

  def delete_expired
    Task.where('deadline < ?', Time.current).destroy_all
    redirect_to tasks_path, notice: '期限切れタスクが削除されました。'
  end


  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :completed, :priority)
  end
end
