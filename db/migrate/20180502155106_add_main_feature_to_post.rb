class AddMainFeatureToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :main_featured, :boolean, default: false
  end
end
