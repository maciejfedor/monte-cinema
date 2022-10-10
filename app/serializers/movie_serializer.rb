class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :duration
  has_many :screenings, if: proc { |record| record.screenings.any? },
                        meta: proc { |movie, _params| { count: movie.screenings.length } }
end
