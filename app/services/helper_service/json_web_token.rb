class HelperService::JsonWebToken
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
        begin
            body = JWT.decode(token, HMAC_SECRET)
            HashWithIndifferentAccess.new body.first
        rescue JWT::DecodeError
            raise HelperService::Error, :invalid_token
        end
    end
end