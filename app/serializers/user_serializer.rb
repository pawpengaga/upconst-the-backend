class UserSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name#, :avatar

  def avatar
    return rails_blob_url(object.avatar.blob)
  end
end
