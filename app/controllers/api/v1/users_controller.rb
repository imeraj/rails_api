class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    user = User.find(params[:id])

    render json: user.as_json(:include => {
            :products => {:only => :id}
        })
  end

  def index
      users = User.all
      expires_in 1.minute, public: true # HTTP caching for mostly static content
      render json: { users: users }, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    if current_user.update(user_params)
        render json: current_user, status: 200
    else
        render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
      current_user.destroy
      head 204
  end

  private
  def user_params
    params.require("user").permit(:email, :password, :password_confirmation)
  end

end
