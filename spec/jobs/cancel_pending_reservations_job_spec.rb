require 'rails_helper'

RSpec.describe CancelPendingReservationsJob, type: :job do
  subject { CancelPendingReservationsJob }

  describe 'job' do
    it 'is proccessed in expected queue' do
      expect(subject).to be_processed_in :default
    end

    it 'enques as expected' do
      expect do
        subject.perform_later
      end.to enqueue_job
    end
  end

  describe 'perform' do
    let(:ticket) { build(:ticket, seat: '1') }
    let(:reservation) { create(:reservation, tickets: [ticket]) }
    before { reservation }

    it 'changes status of reservation to cancelled' do
      expect do
        subject.perform_now
      end.to change { reservation.reload.status }.from('booked').to('cancelled')
    end
  end
end
