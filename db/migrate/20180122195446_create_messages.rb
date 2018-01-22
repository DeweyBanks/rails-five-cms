class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :email
      t.string :interest
      t.text :comment

      t.timestamps
    end
  end
end
