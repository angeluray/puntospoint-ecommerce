class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]

  # GET /api/v1/accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /api/v1/accounts/1
  def show
    render json: @account
  end

  # POST /api/v1/accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/accounts/1
  def destroy
    @account.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:first_name, :last_name, :email, :password, :password_confirmation, :auth_token,
                                    :type)
  end
end
