class TicketSerializer
  include JSONAPI::Serializer

  set_type :ticket
  attributes :seat
  belongs_to :reservation
end
