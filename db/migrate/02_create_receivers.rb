# frozen_string_literal: true

class CreateReceivers < ActiveRecord::Migration[6.1]
  def change
    create_table :receivers do |t|
      t.string :name

      t.timestamps
    end
  end
end
