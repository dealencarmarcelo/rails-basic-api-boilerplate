class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:show, :update, :destroy]

  def index
    users = User.order(name: :asc)
    
    render json: users, status: 200
  end

  def show
    render json: @user, status: 200
  end

  def create
    user = User.new(users_params)

    raise ActiveRecord::RecordInvalid, user unless user.save
    render json: user, status: 201
  end

  def update
    raise ActiveRecord::RecordInvalid, @user unless @user.update(users_params)
    render json: @user, status: 200
  end

  def destroy
    @user.destroy
  end

  private

  def users_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def get_user
    @user = User.find_by_id(params[:id])
    raise ErrorHandler, :not_found if @user.nil?
  end
end