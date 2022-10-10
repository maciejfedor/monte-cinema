require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe '.call' do
    subject(:update_reservation) { described_class.new(id: reservation.id, status: :accepted).call }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
    let(:ticket) { build(:ticket, seat: '1') }
    let(:reservation) { create(:reservation, tickets: [ticket]) }

    it 'updates reservation status' do
      expect { update_reservation }.to change { reservation.reload.status }.from('booked').to('accepted')
    end
  end
end
