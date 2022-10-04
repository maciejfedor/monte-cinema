class CancelPendingReservationsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    reservations.each do |reservation|
      @reservation = reservation
      cancel_reservation if after_deadline?
    end
  end

  private

  attr_reader :reservation

  def reservations
    Reservation.where(status: :booked)
  end

  def deadline
    @reservation.screening.start_time - 30.minutes
  end

  def after_deadline?
    Time.current.after?(deadline)
  end

  def cancel_reservation
    Reservations::UseCases::Cancel.new(id: @reservation.id).call
  end
end
