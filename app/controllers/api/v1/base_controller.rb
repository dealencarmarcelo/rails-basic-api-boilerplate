class Api::V1::BaseController < ApplicationController
  before_action :authorize_request

  private

  def authorize_request
    email = HelperService::JsonWebToken.decode(access_token).values_at(:email)

    @current_user = User.find_by_email(email)

    raise HelperService::Error, :invalid_credentials unless @current_user.present?
  end

  def access_token
    request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end
end