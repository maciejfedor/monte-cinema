module Reservations
  module UseCases
    class Update
      attr_reader :repository, :id, :status

      def initialize(id:, status:, repository: ReservationRepository.new)
        @id = id
        @status = status
        @repository = repository
      end

      def call
        repository.update_reservation(id, status:)
      end
    end
  end
end
