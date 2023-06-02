class Api::V1::SalesController < ApplicationController
  include Authenticable
  before_action :authenticate_request, except: [:create]
  before_action :set_sale, only: %i[ show update destroy ]

  # GET | Set default index action that displays the purchase owner
  def index
    if @current_account.present?
      @sales = Sale.includes(:account).all
      render json: @sales, include: { account: { only: [:id, :name, :address] } }
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # GET | Set show action with authorization
  def show
    if @current_account.present?
      render json: @sale, include: { account: { only: [:id, :name, :address] } }
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # GET | Set purchase registry without granularity
  def purchases_registry_search
    if @current_account.present?
      start_date = params[:start_date]
      end_date = params[:end_date]
      category_id = params[:category_id]
      customer_id = params[:customer_id]
      admin_id = params[:admin_id]
  
      sales = Sale.where(purchased_at: start_date..end_date)
  
      if category_id.present?
        sales = sales.joins(product: :category).where(categories: { id: category_id })
      end
  
      if customer_id.present?
        sales = sales.where(account_id: customer_id)
      end
  
      if admin_id.present?
        sales = sales.joins(product: :account).where(accounts: { id: admin_id })
      end
  
      render json: sales
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # GET | Set purchase registry with granularity
  def purchases_granularity_search
    if @current_account.present?
      start_date = params[:start_date]&.to_date
      end_date = params[:end_date]&.to_date
      category_id = params[:category_id].presence
      customer_id = params[:customer_id].presence
      admin_id = params[:admin_id].presence
      granularity = (params[:granularity] || "day").downcase.strip.to_sym

      if start_date.nil? || end_date.nil? || start_date > end_date
        end_date = Date.current
        start_date = end_date - 29.days
      end

      sales = Sale.where(purchased_at: start_date.beginning_of_day..end_date.end_of_day)
      sales = sales.joins(product: :category).where(categories: { id: category_id }) if category_id.present?
      sales = sales.where(account_id: customer_id) if customer_id.present?
      sales = sales.joins(product: :account).where(accounts: { id: admin_id }) if admin_id.present?

      unless [:hour, :day, :week, :month, :year].include?(granularity)
        render json: { error: "Invalid granularity param" }, status: :bad_request and return
      end
    
      case granularity
      when :hour
        sales = sales.group("date_trunc('hour', purchased_at)").count
        sales = sales.transform_keys { |key| key.strftime("%Y-%m-%d %H:%M:%S") }
      when :day
        sales= sales.group("date_trunc('day', purchased_at)").count
        sales = sales.transform_keys { |key| key.strftime("%Y-%m-%d") }
      when :week
        sales = sales.group("date_trunc('week', purchased_at)").count
        sales = sales.transform_keys { |key| key.strftime("%Y-%m-%d") }
      when :month
        sales = sales.group("date_trunc('month', purchased_at)").count
        sales = sales.transform_keys { |key| key.strftime("%Y-%m") }
      when :year
        sales = sales.group("date_trunc('year', purchased_at)").count
        sales = sales.transform_keys { |key| key.strftime("%Y") }
      end

      render json: sales
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # case granularity
  # when 'hour'
  #   sales = sales.group("date_trunc('hour', purchased_at)").count
  # when 'day'
  #   sales = sales.group("date_trunc('day', purchased_at)").count
  # when 'week'
  #   sales = sales.group("date_trunc('week', purchased_at)").count
  # when'year'
  #   sales = sales.group("date_trunc('year', purchased_at)").count
  # else
  #   render json: { error: "Invalid granularity parameter" }, status: :bad_request and return
  # end
  
  # POST |
  def create
    @sale = Sale.new(sale_params)

    product = Product.find(@sale.product_id)
    customer = Account.find(@sale.account_id)

    # Checks if there is enough stock
    if product.product_stocks < @sale.product_amount
      render json: { error: "Insufficient stock" }, status: :unprocessable_entity
    else
      @sale.total_price = product.price * @sale.product_amount
      
      if customer.type == "customer" && customer.balance < @sale.total_price
        render json: { error: "Insufficient balance" }, status: :unprocessable_entity
      else
          if customer.type == "customer"
            customer.balance -= @sale.total_price  # Subtract the sale amount from the customer's balance
            customer.save
          end
      end
    end
      
    product_owner = product.account
    @sale.admin_id = product_owner.id

    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PUT | Set action with authorization
  def update
    if @current_account.present? && @current_account.role_level == 0 || @current_account.role_level == 1
      if @sale.update(sale_params)
        render json: @sale
      else
        render json: @sale.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  # DELETE /sales/1
  def destroy
    if @current_account.present? && @current_account.role_level == 0 || @current_account.role_level == 1
      @sale.destroy
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Trusted params
    def sale_params
      params.require(:sale).permit(:product_amount, :total_price, :purchased_at, :admin_id, :product_id, :category_id, :account_id)
    end
end
