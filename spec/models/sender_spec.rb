# frozen_string_literal: true

require 'rails_helper'

describe Sender do
  let!(:sender) { create(:sender) }

  describe '#send_to' do
    context 'when content is blank' do
      let!(:receiver) { create(:receiver) }

      it 'raises error' do
        expect { sender.send_to(receiver, '   ') }.to(
          raise_error(ArgumentError, 'Content is blank')
        )
      end
    end

    context 'when receiver does not have transport' do
      let!(:receiver) { create(:receiver) }

      it 'raises error' do
        expect { sender.send_to(receiver, 'first message') }.to(
          raise_error(ArgumentError, 'Receiver does not have a transport')
        )
      end
    end

    context 'when sending first message' do
      let!(:receiver) { create(:receiver, :with_whatsapp) }

      it 'sends message' do
        expect { sender.send_to(receiver, 'first message') }.to(
          change { receiver.transmissions.count }.from(0).to(1)
        )
      end
    end

    context 'when not first message' do
      let!(:receiver) { create(:receiver, :with_whatsapp) }

      before do
        sender.send_to(receiver, 'first message')
      end

      it 'sends message' do
        expect { sender.send_to(receiver, 'first message') }.to(
          change { receiver.transmissions.count }.by(1)
        )
      end
    end
  end
end
