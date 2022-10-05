require 'rails_helper'

RSpec.describe Reservations::UseCases::Create do
  let(:seats) { [*'10'..'13'] }
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }
  let(:screening) { create(:screening, hall:, movie:, start_time: Date.current + 2.days) }
  let(:params) do
    {
      screening_id: screening.id,
      user_id: user.id,
      seats: seats,
      status: :booked
    }
  end

  let(:instance) { described_class.new(**params).call }

  describe '.call' do
    it 'creates reservation' do
      expect{ instance }.to change(Reservation, :count).by(1)
    end

    it 'creates tickets' do
      expect{ instance }.to change(Ticket, :count).by(4)
    end

    it 'returns reservation with proper attributes' do
      expect(instance.data).to have_attributes(screening_id: screening.id, user_id: user.id, status: 'booked')
    end

    it 'returns reservation without errors' do
      expect(instance.errors).to match_array([])
    end

    context 'when seats invalid' do
      let(:seats) { [] }
      let(:instance) { described_class.new(**params).call }
      it 'does not create reservation' do
        expect { instance }.not_to change(Reservation, :count)
      end
      it 'does not create tickets' do
        expect { instance }.not_to change(Ticket, :count)
      end
    end
  end
end
