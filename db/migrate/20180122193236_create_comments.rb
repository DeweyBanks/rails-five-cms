class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :website
      t.text :body
      t.string :commentable_type
      t.integer :commentable_id

      t.timestamps
    end
  end
end
