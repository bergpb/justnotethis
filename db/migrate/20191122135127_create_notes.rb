# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :title
      t.text :description
      t.references :user
      t.timestamps null: false
    end
  end

  def down
    drop_table :notes
  end
end
