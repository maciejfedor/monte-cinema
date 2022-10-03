require 'rails_helper'

RSpec.describe Reservations::UseCases::Cancel do
  describe ".call" do
    let(:seats) { [10, 11, 12, 13] }
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall_id: hall.id, movie_id: movie.id, start_time: Date.current + 2.days) }
    let(:reservation) { create(:reservation, screening_id: screening.id, status: 0) }
    let(:params) do { id: reservation.id }
    
  end

  subject(:cancel_reservation) { described_class.new(**params).call }

  it 'cancels reservation' do
    expect{ cancel_reservation }.to change { reservation.reload.status }.from('booked').to('cancelled')
    end
  end
end
