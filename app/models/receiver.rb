# frozen_string_literal: true

class Receiver < ApplicationRecord
  has_many :transports, dependent: :destroy
  has_many :transmissions, through: :transports
  has_many :messages, -> { distinct }, through: :transmissions

  class_eval do
    Transport::NAMES.each_key do |name|
      define_method(name) { transports.find_by(name: name) }

      define_method("create_#{name}") do
        transports.find_or_create_by(name: name)
      end
    end
  end

  def mru_transport
    transmissions.order(created_at: :desc)&.first&.transport.presence || transports.order(created_at: :desc)&.first
  end
end
