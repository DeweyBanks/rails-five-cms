class AddRankToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :rank, :integer
  end
end
