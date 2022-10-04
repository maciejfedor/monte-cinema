require 'rails_helper'

RSpec.describe Reservations::UseCases::Cancel do
  describe ".call" do
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
    let(:reservation) { create(:reservation, screening:, status: :booked) }
    let(:params) do 
      { id: reservation.id }
    end

  subject(:cancel_reservation) { described_class.new(**params).call }

  it 'cancels reservation' do
    expect{ cancel_reservation }.to change { reservation.reload.status }.from('booked').to('cancelled')
    end
  end
end
