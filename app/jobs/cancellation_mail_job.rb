class CancellationMailJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    reservation = Reservations::UseCases::Find.new(id: reservation_id).call
    ReservationMailer.cancellation_for(reservation.id).deliver_later
  end
end
