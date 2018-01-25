class DropRole < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :role, index: true, foreign_key: true
    drop_table :roles
  end
end
