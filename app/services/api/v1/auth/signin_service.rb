class Api::V1::Auth::SigninService
  prepend SimpleCommand
  extend Initializable
  values :auth_params

  def call
    signin
  end

  private

  attr_accessor :auth_params

  def signin
    user = User.find_by_email(auth_params[:email])
    
    raise ErrorHandler, :invalid_credentials unless user&.authenticate(auth_params[:password])

    token = HelperService::JsonWebToken.encode(id: user.id, email: user.email)

    HelperService::Response.ok({ token: token, user: user })
  end
end