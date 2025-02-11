class TasksController < ApplicationController
  before_action :authorize_request
  before_action :set_task ,only: [:show , :update , :destroy]
  before_action :set_user, only: [:index]
  before_action :set_project, only: [:create]
  load_and_authorize_resource
    
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

  # def create
  #   @task = Task.new(task_params)
  #   if @task.save
  #     render json: @task, status: :created
  #   else
  #     render json: @task.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    if current_user.nil?
      return render json: { error: "User not authenticated" }, status: :unauthorized
    end   
    @task = @project.tasks.build(task_params)
    @task.user_id = current_user.id 
    if @task.save
      if @task.user_id.present?
        ActionCable.server.broadcast(
          "notification_#{@task.user_id}",
          { message: "You have been assigned a new task: #{@task.name}" }
        )
      end
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

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :project_id, :status)
  end
  
end
