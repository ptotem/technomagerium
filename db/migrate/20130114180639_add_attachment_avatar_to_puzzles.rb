class AddAttachmentAvatarToPuzzles < ActiveRecord::Migration
  def self.up
    change_table :puzzles do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :puzzles, :avatar
  end
end
