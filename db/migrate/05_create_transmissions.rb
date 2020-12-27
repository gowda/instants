# frozen_string_literal: true

class CreateTransmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :transmissions do |t|
      t.string :name
      t.references :transport, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
