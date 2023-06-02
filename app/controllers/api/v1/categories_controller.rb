class Api::V1::CategoriesController < ApplicationController
  include Authenticable
  before_action :authenticate_request, only: [:purchases_registry, :earnings_registry, :create, :update, :destroy]
  before_action :set_category, only: %i[ show update destroy ]


  # GET | Set default response of all products
  def index
    @categories = Category.all
    render json: @categories
  end
  
  # GET | Registry of products per category
  def show
    render json: @category, include: { products: { only: [:id, :name, :price] } }
  end

  # GET | Registry sales per product
  def purchases_registry
    if @current_account.present?
      @categories = Category.all
      @product_most_purchased = []
      
      @categories.each do |category|
        products = category.products.group(:id).order("SUM(sales_count) DESC").limit(10)
        category_products_group = {
          id: category.id
          name: category.name,
          products: products.map do |product|
            {
              id: product.id,
              name: product.name,
              sales_count: product.sales_count
            }
          end
        }
        @product_most_purchased << category_products_group
      end
      
      render json: @product_most_purchased
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # GET | Earnings registry with authorization check
  def earnings_registry
    if @current_account.present?
      @categories = Category.all
      @product_earnings = []
      
      @categories.each do |category|
        products = category.products.order(product_earnings: :desc).limit(3)
        category_products_earning_group = {
          id: category.id
          name: category.name,
          products: products.map do |product|
            {
              id: product.id,
              name: product.name,
              earnings: product.product_earnings
            }
          end
        }
        @product_earnings << category_products_earning_group
      end
      
      render json: @product_earnings
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # POST | Set create action with authorization check
  def create
    if @current_account.present?
      @category = Category.new(category_params)

      if @category.save
        render json: @category, status: :created, location: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # PUT | Set update action with authorization check
  def update
    if @current_account.present? && @current_account.role_level == 0 || @current_account.role_level == 1
      if @category.update(category_params)
        render json: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # DELETE | Set destroy action with authorization check
  def destroy
    if @current_account.present? && @current_account.role_level == 0 || @current_account.role_level == 1
      @category.destroy
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end  
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :products_count)
  end
end
