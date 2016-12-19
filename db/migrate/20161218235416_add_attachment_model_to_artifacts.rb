class AddAttachmentModelToArtifacts < ActiveRecord::Migration
  def self.up
    change_table :artifacts do |t|
      t.attachment :model
    end
  end

  def self.down
    remove_attachment :artifacts, :model
  end
end
