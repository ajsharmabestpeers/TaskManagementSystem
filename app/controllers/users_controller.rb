class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user ,only: [:show , :update , :destroy]
  # before_action :find_user, except: %i[create index]

  def index
    render json: User.all
  end

  def show
    render json: @user, include: ['projects', 'tasks']
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  # def find_user
  #   @user = User.find_by_username!(params[:_username])
  #   rescue ActiveRecord::RecordNotFound
  #     render json: { errors: 'User not found' }, status: :not_found
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
