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

end
