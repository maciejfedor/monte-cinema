class ScreeningSerializer
  include JSONAPI::Serializer

  set_type :screening
  attributes :start_time, :end_time
  belongs_to :movie
  belongs_to :hall
end
