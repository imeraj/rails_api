class Api::V1::OrdersController < ApplicationController
    before_action :authenticate_with_token!
    respond_to :json

    def index
        orders = current_user.orders
        render json: { orders: orders }, status: 200
    end

    def show
        order = current_user.orders.find(params[:id])
        render json: { order: order }, status: 200
    end

    def create
        order = current_user.orders.build(order_params)

        if order.save
            render json: order, status: 201, location: [current_user, order]
        else
            render json: { errors: order.erros }, status: 422
        end
    end

    private
    def order_params
        params.require(:order).permit(:product_ids => [])
    end

end
