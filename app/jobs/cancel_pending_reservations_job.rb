class CancelPendingReservationsJob < ApplicationJob
  queue_as :default

  def perform
    return if reservations.empty?

    reservations.each do |reservation|
      cancel_reservation(reservation) if after_deadline?(reservation)
    end
  end

  private

  attr_reader :reservation

  def reservations
    Reservation.where(status: :booked)
  end

  def after_deadline?(reservation)
    Time.current.after?(reservation.screening.start_time - 30.minutes)
  end

  def cancel_reservation(reservation)
    Reservations::UseCases::Cancel.new(id: reservation.id).call
    CancellationMailJob.perform_now(reservation.id) if reservation.user
  end
end
