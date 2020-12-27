# frozen_string_literal: true

require 'rails_helper'

describe Receiver do
  let!(:receiver) { create(:receiver) }

  describe '#create_whatsapp' do
    context 'when no transport setup' do
      it 'returns newly created transport' do
        expect { receiver.create_whatsapp }.to(
          change { receiver.transports.count }.from(0).to(1)
        )
      end
    end

    context 'when transport is setup' do
      before { receiver.create_whatsapp }

      it 'returns existing transport' do
        expect { receiver.create_whatsapp }.not_to(
          change { receiver.transports.count }
        )
      end
    end
  end

  describe '#whatsapp' do
    context 'when no transport setup' do
      it 'returns nil' do
        expect(receiver.whatsapp).to be_nil
      end
    end

    context 'when transport is setup' do
      let!(:transport) { receiver.create_whatsapp }

      it 'returns transport' do
        expect(receiver.whatsapp).to eql(transport)
      end
    end
  end

  describe '#mru_transport' do
    context 'when transport setup' do
      it 'returns nil' do
        expect(receiver.mru_transport).to be_nil
      end
    end

    context 'when no message sent' do
      before { receiver.create_whatsapp }

      let!(:imessage) { receiver.create_imessage }

      it 'returns most recently created transport' do
        expect(receiver.mru_transport).to eql(imessage)
      end
    end

    context 'when message sent' do
      let!(:receiver) { create(:receiver_with_all_transports) }
      let!(:message) { create(:message, :with_sender) }

      before do
        message.send_via(receiver.whatsapp)
        message.send_via(receiver.imessage)
        message.send_via(receiver.sms)
      end

      it 'returns most recently used transport' do
        expect(receiver.mru_transport).to eql(receiver.sms)
      end
    end
  end
end
