class AddColumnsToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :longitude, :float
    add_column :artifacts, :latitude, :float
    add_column :artifacts, :filepath, :text
  end
end
