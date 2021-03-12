class Api::V1::Auth::SignupService
  prepend SimpleCommand
  extend Initializable
  values :auth_params

  def call
    signup
  end

  private

  attr_accessor :auth_params

  def signup
    user = User.new(auth_params)

    raise ActiveRecord::RecordInvalid, user unless (user.save && user.authenticate(auth_params[:password]))

    token = HelperService::JsonWebToken.encode(id: user.id, email: user.email)

    HelperService::Response.created({ token: token, user: user })
  end
end