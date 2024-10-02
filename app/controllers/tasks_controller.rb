class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]

  # タスク一覧表示
  
    def index
      # すべてのタスクを取得する
      @tasks = Task.all
  
      # 以下はフィルタ処理
      if params[:priority].present?
        @tasks = @tasks.where(priority: params[:priority])
      end
  
      if params[:expired] == 'true'
        @tasks = @tasks.where('deadline < ?', Date.today)
      elsif params[:expired] == 'false'
        @tasks = @tasks.where('deadline >= ?', Date.today).or(@tasks.where(deadline: nil))
      end
  
      if params[:completed].present?
        @tasks = @tasks.where(completed: params[:completed] == 'true')
      end
    end
  
  

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが作成されました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクが削除されました。'
  end

  def toggle_complete
    @task.update(completed: !@task.completed)
    redirect_to tasks_path, notice: 'タスクの状態が更新されました。'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :completed, :priority)
  end
end
