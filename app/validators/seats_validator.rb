class SeatsValidator
  attr_reader :errors

  def self.validate!(screening:, seats:)
    return false if seats.blank?
    return false if seat_taken?(screening, seats)

    true
  end

  def seat_taken?(screening, seats)
    seats.each do |seat|
      return true unless screening.available_seats.include? seat
    end
    false
  end
end
