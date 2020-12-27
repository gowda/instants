# frozen_string_literal: true

class CreateTransports < ActiveRecord::Migration[6.1]
  def up
    case adapter
    when :sqlite
      sqlite_create_table
    else
      non_sqlite_create_table
    end

    add_index :transports, %i[name receiver_id], unique: true
  end

  def down
    remove_index :transports, name: 'index_transports_on_name_and_receiver_id'
    drop_table :transports
  end

  private

  def non_sqlite_create_table
    create_table :transports do |t|
      t.string :name
      t.references :receiver, null: false, foreign_key: true

      t.timestamps
    end

    execute alter_name_to_enum_statement
  end

  def alter_name_to_enum_statement
    <<~SQL.squish
      ALTER TABLE transports MODIFY name enum(#{enum_values});
    SQL
  end

  def sqlite_create_table
    execute sqlite_create_statement
  end

  def sqlite_create_statement
    <<~SQL.squish
      CREATE TABLE IF NOT EXISTS "transports" (
        "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
        "name" varchar,
        "receiver_id" integer NOT NULL,
        "created_at" datetime(6) NOT NULL,
        "updated_at" datetime(6) NOT NULL,
        CONSTRAINT "enum_check_transports_name" CHECK ("name" IN (#{enum_values})),
        CONSTRAINT "fk_transports_receivers" FOREIGN KEY ("receiver_id") REFERENCES "receivers" ("id")
      );
    SQL
  end

  def enum_values
    Transport::NAMES.values.map { |v| "'#{v}'" }.join(',')
  end

  def adapter
    connection.adapter_name.downcase.to_sym
  end
end
