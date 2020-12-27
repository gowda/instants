# frozen_string_literal: true

class CreateSenders < ActiveRecord::Migration[6.1]
  def change
    create_table :senders do |t|
      t.string :name

      t.timestamps
    end
  end
end
