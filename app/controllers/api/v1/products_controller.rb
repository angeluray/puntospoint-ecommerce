class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = Product.all

    render json: @products
  end
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    @category = Category.find(params[:category_id])

    if @product.save
      ProductCategorization.create(product_id: @product.id, category_id: @category.id)
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :sales_count, :product_stocks, :sold_products,
                                    :product_earnings, :available, :account_id)
  end
end
