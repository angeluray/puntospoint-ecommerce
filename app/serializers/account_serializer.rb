class AccountSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :username, :role_level, :type
end
