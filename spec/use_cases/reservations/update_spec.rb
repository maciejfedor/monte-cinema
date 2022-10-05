require 'rails_helper'

RSpec.describe Reservations::UseCases::Update do
  describe '.call' do
    let(:seats) { [*'10'..'13'] }
    let(:movie) { create(:movie) }
    let(:hall) { create(:hall) }
    let(:user) { create(:user) }
    let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
    let(:reservation) do
      Reservations::UseCases::Create.new(screening_id: screening.id,
                                         seats:,
                                         user_id: user.id,
                                         status: :booked).call
    end

    let(:params) do
      {
        id: reservation.id,
        status: :accepted

      }
    end

    let(:update_reservation) { described_class.new(**params).call }

    it 'updates reservation status' do
      expect { update_reservation }.to change { reservation.reload.status }.from('booked').to('accepted')
    end
  end
end
