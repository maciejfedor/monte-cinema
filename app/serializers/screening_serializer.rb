class ScreeningSerializer
  include JSONAPI::Serializer

  set_type :screening
  attributes :start_time, :available_seats
  belongs_to :movie
  belongs_to :hall
end
