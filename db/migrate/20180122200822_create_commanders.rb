class CreateCommanders < ActiveRecord::Migration[5.1]
  def change
    create_table :commanders do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.text :about

      t.timestamps
    end
  end
end
