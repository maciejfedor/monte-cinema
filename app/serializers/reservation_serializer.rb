class ReservationSerializer
  include JSONAPI::Serializer

  set_type :reservation
  attributes :status
  belongs_to :screening
  belongs_to :user
  has_many :tickets
end
