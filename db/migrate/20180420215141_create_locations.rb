class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :location_type
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
