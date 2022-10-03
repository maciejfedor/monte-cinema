require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe ".call" do
    let(:seats) { [10, 11, 12, 13] }
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall_id: hall.id, movie_id: movie.id, start_time: Date.current + 2.days) }
    let(:reservation) { create(:reservation, screening_id: screening.id, status: 0) }
    let(:params) do {
      id: reservation.id,
      status: 2,
    }
  end

  subject(:update_reservation) { described_class.new(**params).call }

  it 'updates reservation status' do
    expect{ update_reservation }.to change { reservation.reload.status }.from('booked').to('accepted')
    end
  end
end
