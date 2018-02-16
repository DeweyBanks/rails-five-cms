class AddFieldsToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :caption, :string
    add_column :pictures, :alt, :string
  end
end
