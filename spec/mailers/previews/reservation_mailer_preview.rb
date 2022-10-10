# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/confirmation
  def confirmation
    reservation = Reservation.last
    ReservationMailer.confirmation_for(reservation.id)
  end

  def cancellation
    reservation = Reservation.last
    ReservationMailer.cancellation_for(reservation.id)
  end
end
