class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :email
  has_many :reservations
end
