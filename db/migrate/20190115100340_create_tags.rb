class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
        t.text :tag
        t.timestamps null: false
    end
  end
  def down
    drop_table :tags
  end
end
