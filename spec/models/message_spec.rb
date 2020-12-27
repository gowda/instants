# frozen_string_literal: true

require 'rails_helper'

describe Message do
  let!(:message) { create(:message, :with_sender) }

  describe '#send_via' do
    context 'when transport is nil' do
      it 'raises error' do
        expect { message.send_via(nil) }.to(
          raise_error(ArgumentError, 'Transport cannot be nil')
        )
      end
    end
  end
end
