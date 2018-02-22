class AddFieldsToCommanders < ActiveRecord::Migration[5.1]
  def change
    add_column :commanders, :emps_id, :integer
    add_column :commanders, :facility_id, :integer
  end
end
