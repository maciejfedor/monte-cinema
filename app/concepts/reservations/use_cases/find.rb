module Reservations
  module UseCases
    class Find
      attr_reader :id, :repository

      def initialize(id:, repository: ReservationRepository.new)
        @id = id
        @repository = repository
      end

      def call
        repository.find(id)
      end
    end
  end
end
