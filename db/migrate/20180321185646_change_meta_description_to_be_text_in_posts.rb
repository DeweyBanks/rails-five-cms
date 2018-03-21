class ChangeMetaDescriptionToBeTextInPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :meta_description, :text
  end
end
