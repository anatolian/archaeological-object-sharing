class AddFileToArtifacts < ActiveRecord::Migration
  
  def up
    add_attachment :artifacts, :file
  end

  def down
    remove_attachment :artifacts, :file
  end

end
