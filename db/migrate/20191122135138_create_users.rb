class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
        t.text :username
        t.text :email
        t.text :password_digest
        t.timestamps null: false
    end
  end
  def down
    drop_table :users
  end
end
