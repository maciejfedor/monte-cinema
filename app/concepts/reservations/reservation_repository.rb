module Reservations
  class ReservationRepository
    attr_reader :adapter

    def initialize(adapter: Reservation)
      @adapter = adapter
    end

    def find(id)
      adapter.find(id)
    end

    def find_all
      adapter.includes(:tickets)
    end
  end
end
