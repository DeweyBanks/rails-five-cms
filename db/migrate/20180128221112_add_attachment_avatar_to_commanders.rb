class AddAttachmentAvatarToCommanders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :commanders do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :commanders, :avatar
  end
end
