class AddAttachmentAvatarToTomes < ActiveRecord::Migration
  def self.up
    change_table :tomes do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :tomes, :avatar
  end
end
