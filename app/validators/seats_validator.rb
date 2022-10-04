class SeatsValidator
  def self.validate!(screening:, seats:, errors:)
    errors.push('Seat must be chosen') if seats.blank?
    errors.push('Seat taken') if !seats.blank? && seat_taken?(screening, seats)
  end

  def self.seat_taken?(screening, seats)
    seats.each do |seat|
      return true unless screening.available_seats.include? seat
    end
    false
  end
end
