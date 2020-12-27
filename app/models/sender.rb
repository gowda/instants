# frozen_string_literal: true

class Sender < ApplicationRecord
  has_many :messages, dependent: :destroy

  def send_to(receiver, content)
    raise ArgumentError, 'Content is blank' if content.blank?
    raise ArgumentError, 'Receiver does not have a transport' if receiver.mru_transport.nil?

    message = messages.create!(content: content)
    message.send_via(receiver.mru_transport)
  end
end
