# frozen_string_literal: true

class CreateLinguists < ActiveRecord::Migration[6.1]
  def change
    create_table :linguists do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :country, null: false
      t.string :native_language, null: false
      t.string :target_language, null: false
      t.string :source, index: true, null: false

      t.timestamps
    end
  end
end
