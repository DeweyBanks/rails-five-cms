class AddCategoryAndCampaignToPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :category, foreign_key: true
    add_reference :posts, :campaign, foreign_key: true
  end
end
