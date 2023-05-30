# frozen_string_literal: true

class Api::V1::Accounts::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
end
