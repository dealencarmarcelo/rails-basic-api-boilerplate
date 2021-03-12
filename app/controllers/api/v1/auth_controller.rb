class Api::V1::AuthController < ApplicationController

  def signin
    @result = Api::V1::Auth::SigninService.call(auth_params).result
    render_data
  end

  def signup
    @result = Api::V1::Auth::SignupService.call(auth_params).result
    render_data
  end

  private

  def auth_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def render_data
    render json: @result[:data], status: @result[:status]
  end
end