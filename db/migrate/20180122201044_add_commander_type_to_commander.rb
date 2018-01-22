class AddCommanderTypeToCommander < ActiveRecord::Migration[5.1]
  def change
    add_reference :commanders, :commander_type, foreign_key: true
  end
end
