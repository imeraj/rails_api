class Api::V1::OrdersController < ApplicationController
    before_action :authenticate_with_token!
    respond_to :json

    def index
        orders = current_user.orders
        render json: { orders: orders }, status: 200
    end

    def show
        order = current_user.orders.find(params[:id])
        # ETag caching: Consumer must send If-None-Match (Etag)
        # or If-Modified-Since (Last Modified)
        if stale?(etag: order, last_modified: order.created_at, public: true)
            render json: { order: order }
        end
    end

    def create
        order = current_user.orders.build(order_params)

        if order.save
            order.reload #we reload the object so the response displays the product objects
            Publisher.broadcast_event('order.confirmation', order: order)
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
