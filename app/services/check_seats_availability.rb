class CheckSeatsAvailability
  def initialize(seats:, screening_id:)
    @seats = seats
    @screening_id = screening_id
  end

  def call
    # it's a perfect place to get a screening's reservations and taken seats
    # then take all seats from screening's hall
    true
  end
end
