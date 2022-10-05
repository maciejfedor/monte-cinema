module Reservations
  module UseCases
    class Cancel
      attr_reader :id, :repository

      def initialize(id:, repository: ReservationRepository.new)
        @id = id
        @repository = repository
      end

      def call
        repository.update_reservation!(id, status: :cancelled)
      end
    end
  end
end
