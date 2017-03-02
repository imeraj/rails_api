class Api::V1::SessionsController < ApplicationController
    respond_to :json

    def create
        email = params[:session][:email]
        password = params[:session][:password]
        user = email.present? && User.find_by(email: email)

        if user.valid_password?(password)
            sign_in user, store: false
            user.generate_auth_token!
            user.save
            render json: user, status: 200
        else
            render json: { errors: "Invalid email or password" }
        end
    end

    def destroy
        if signed_in?
            current_user.generate_auth_token!
            current_user.save
            head 204
        else
            render json: { errors: "Please log in first" }, status: 422
        end
    end

end
