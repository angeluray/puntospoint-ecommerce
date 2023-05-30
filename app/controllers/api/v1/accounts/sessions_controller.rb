# frozen_string_literal: true

class Api::V1::Accounts::SessionsController < Devise::SessionsController
  respond_to :json
  
end
