class AddColumnActiveToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :active, :boolean, default: true
  end
end