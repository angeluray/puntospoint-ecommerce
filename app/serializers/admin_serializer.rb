class AdminSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :type
end
