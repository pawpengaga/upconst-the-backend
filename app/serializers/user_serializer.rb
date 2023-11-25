class UserSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name, :avatar_url
end
