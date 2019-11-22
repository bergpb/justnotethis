class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
        t.text :title
        t.text :description
        t.references :user
        t.timestamps null: false
    end
  end
  def down
    drop_table :tasks
  end
end
