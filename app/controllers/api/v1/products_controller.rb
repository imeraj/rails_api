class Api::V1::ProductsController < ApplicationController
    before_action :authenticate_with_token!

    def index
        page = params[:page].present? ? params[:page] : 1
        per_page = params[:per_page].present? ? params[:per_page]: 10

        products = Product.all.page(page).per(params[per_page])

        render json: { products: products, meta: {
                                    pagination:
                                         { per_page: per_page,
                                           total_pages: products.total_pages,
                                           total_objects: products.total_count }}},
                                    status: 200
    end

    def show
        respond_with Product.find(params[:id])
    end

    def create
        product = current_user.products.build(product_params)
        if product.save
            render json: product, status: 201, location: product
        else
            render json: { errors: product.errors }, status: 422
        end
    end

    def update
        product = current_user.products.find(params[:id])
        if product && product.update(product_params)
            render json: product, status: 200
        else
            render json: { errors: product.errors }, status: 422
        end
    end

    def destroy
        product = current_user.products.find(params[:id])
        product.destroy
        head 204
    end

    private

    def product_params
        params.require(:product).permit(:title, :price, :published)
    end
end
