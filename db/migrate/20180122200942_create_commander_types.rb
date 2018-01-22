class CreateCommanderTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :commander_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
