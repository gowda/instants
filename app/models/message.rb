# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender
  has_many :transmissions, dependent: :destroy
  has_many :transports, through: :transmissions

  def receiver
    transports.first.receiver
  end

  def send_via(transport)
    raise ArgumentError, 'Transport cannot be nil' if transport.nil?

    transmissions.create!(transport: transport)
  end
end
