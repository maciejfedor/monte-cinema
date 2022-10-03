require 'rails_helper'

RSpec.describe Reservations::UseCases::Create do
  let(:seats) { [10, 11, 12, 13] }
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:hall) { create(:hall) }
  let(:screening) { create(:screening, hall_id: hall.id, movie_id: movie.id, start_time: Date.current + 2.days) }
  let(:params) do
    {
      screening_id: screening.id,
      user_id: user.id,
      seats:,
      status: 0

    }
  end

  let(:instance) { described_class.new(**params) }

  describe '.call' do
    it 'creates reservation' do
      expect { instance.call }.to change(Reservation, :count).by(1)
    end

    it 'creates tickets' do
      expect { instance.call }.to change(Ticket, :count).by(4)
    end

    it 'returns reservation with tickets' do
      expect(instance.call.tickets.count).to eq(4)
    end

    it 'returns reservation with proper attributes' do
      expect(instance.call).to have_attributes(screening_id: screening.id, user_id: user.id, status: 'booked')
    end

    it 'returns reservation without errors' do
      expect(instance.call.errors).to match_array([])
    end

    context 'when seats invalid' do
      let(:params) do
        {
          screening_id: screening.id,
          user_id: user.id,
          seats: [],
          status: 0
        }
      end
      it 'does not create reservation' do
        expect { instance.call }.not_to change(Reservation, :count)
      end
      it 'does not create tickets' do
        expect { instance.call }.not_to change(Ticket, :count)
      end
    end
  end
end
