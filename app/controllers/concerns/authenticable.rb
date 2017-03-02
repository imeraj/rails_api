module Authenticable

    def current_user
        @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
    end

    def authenticate_with_token!
        render json: { errors: "Not authenticated" }, status: :unauthorized unless signed_in?
    end

    def signed_in?
        current_user.present?
    end

    def sign_out
        @current_user = nil
    end

end
