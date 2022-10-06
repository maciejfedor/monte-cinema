require 'rails_helper'

RSpec.describe Reservations::UseCases::Cancel do
  describe '.call' do
    subject(:cancel_reservation) { described_class.new(id: id).call }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
    let(:ticket) { build(:ticket, seat: '1') }
    let(:reservation) { create(:reservation, tickets: [ticket]) }
    let(:id) { reservation.id }

    it 'cancels reservation' do
      expect { cancel_reservation }.to change { reservation.reload.status }.from('booked').to('cancelled')
    end
  end
end
