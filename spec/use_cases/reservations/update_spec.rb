require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe '.call' do
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
    let(:reservation) { create(:reservation, :skip_validate) }

    let(:params) do
      {
        id: reservation.id,
        status: :accepted

      }
    end

    subject(:update_reservation) { described_class.new(**params).call }

    it 'updates reservation status' do
      expect { update_reservation }.to change { reservation.reload.status }.from('booked').to('accepted')
    end
  end
end
