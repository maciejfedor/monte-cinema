class CancelAllReservationsJob < ApplicationJob
  queue_as :default

  def perform(screening_id)
    reservations = reservations(screening_id)
    return if reservations.empty?

    reservations.each do |reservation|
      cancel_reservation(reservation)
    end
  end

  private

  attr_reader :reservation, :screening_id

  def reservations(screening_id)
    Reservation.where.not(status: :cancelled).where(screening_id: screening_id)
  end

  def cancel_reservation(reservation)
    Reservations::UseCases::Cancel.new(id: reservation.id).call
    CancellationMailJob.perform_now(reservation.id) if reservation.user
  end
end
