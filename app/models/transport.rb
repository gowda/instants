# frozen_string_literal: true

class Transport < ApplicationRecord
  NAMES = { whatsapp: 'WhatsApp', imessage: 'iMessage', sms: 'SMS' }.freeze
  enum name: NAMES

  belongs_to :receiver
  has_many :transmissions, dependent: :destroy
end
