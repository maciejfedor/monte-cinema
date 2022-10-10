class ConfirmationMailJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    reservation = Reservations::UseCases::Find.new(id: reservation_id).call
    ReservationMailer.confirmation_for(reservation.id).deliver_later
  end
end
