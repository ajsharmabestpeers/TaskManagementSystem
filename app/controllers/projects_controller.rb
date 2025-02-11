class ProjectsController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  before_action :authorize_user, only: [:create] 
  before_action :set_project ,only: [:show , :update , :destroy]
  before_action :set_user, only: [:index]
  load_and_authorize_resource

  def index
    # render json: Project.all
    render json: @user.projects
  end

  def show
    render json: @project
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = @current_user.id
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id]) 
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id)
  end

  def authorize_user

    if !['admin', 'project_manager'].include?(@current_user.role)
      render json: { error: 'Unauthorized' }, status: :forbidden
    end
  end
  
end

