class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]

  # タスク一覧表示
  def index
    @tasks = Task.all.order(priority: :desc, deadline: :asc)
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
