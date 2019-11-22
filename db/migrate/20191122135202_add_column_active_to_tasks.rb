class AddColumnActiveToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :active, :boolean, default: true
  end
end
