class AddStatusToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :status, :string, null: false, default: "preview"
  end
end
