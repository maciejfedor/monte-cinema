require 'rails_helper'

RSpec.describe Reservations::UseCases::Cancel do
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
        id: reservation.id
      }
    end

    let(:cancel_reservation) { described_class.new(**params).call }

    it 'cancels reservation' do
      expect { cancel_reservation }.to change { reservation.reload.status }.from('booked').to('cancelled')
    end
  end
end
