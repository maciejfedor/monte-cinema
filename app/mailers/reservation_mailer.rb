class ReservationMailer < ApplicationMailer
  default from: 'MonteCinema <montecinema@monterail.com>'
  def confirmation_for(reservation_id)
    @reservation = Reservations::UseCases::Find.new(id: reservation_id).call
    @screening = @reservation.screening
    mail(subject: "Your reservation for #{@screening.movie.title} is booked!", to: @reservation.user.email)
  end

  def cancellation_for(reservation_id)
    @reservation = Reservations::UseCases::Find.new(id: reservation_id).call
    @screening = @reservation.screening
    mail(subject: "Your reservation for #{@screening.movie.title} is cancelled", to: @reservation.user.email)
  end
end
