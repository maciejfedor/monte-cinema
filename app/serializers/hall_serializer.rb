class HallSerializer
  include JSONAPI::Serializer
  attributes :name, :capacity
  has_many :screenings
end
