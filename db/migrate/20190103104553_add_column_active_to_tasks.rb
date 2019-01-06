class AddColumnActiveToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :active, :boolean
  end
end
