class AddForeignKeyToTasks < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tasks, :users
  end
end
