module Authenticable
  extend ActiveSupport::Concern
  
  private
  
  def authenticate_request
    return render_unauthorized('Authorization header missing') unless request.headers['Authorization'].present?
    return render_unauthorized('No current session') unless current_user.present?
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.admin_jwt_secret_key!).first
    @current_account = Account.find(jwt_payload['sub'])

    unless @current_account.type == 'admin'
      return render_unauthorized('Unauthorized')
    end

    rescue JWT::DecodeError => e
      Rails.logger.error("JWT decode error: #{e.message}")
      render_unauthorized('Invalid token')
    end

    def render_unauthorized(message)
      render json: { error: message }, status: :unauthorized
    end
  end
end