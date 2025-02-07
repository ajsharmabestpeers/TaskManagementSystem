class TasksController < ApplicationController
    
  def index
    @tasks = Task.all
    @tasks = @tasks.where(status: params[:status]) if params[:status].present?
    @tasks = @tasks.where(user_id: params[:user_id]) if params[:user_id].present?
    @tasks = @tasks.where(project_id: params[:project_id]) if params[:project_id].present?
  
    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :project_id, :status)
  end
end
