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

    def create_reservation(params)
      adapter.create!(params)
    end

    def update_reservation(id, params)
      adapter.update!(id, params)
    end
  end
end
