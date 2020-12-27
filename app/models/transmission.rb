# frozen_string_literal: true

class Transmission < ApplicationRecord
  belongs_to :transport
  belongs_to :message
end
