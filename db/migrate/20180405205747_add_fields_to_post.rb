class AddFieldsToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :username, :string
    add_column :posts, :password_digest, :string
    add_column :posts, :locked, :boolean, default: false
  end
end
