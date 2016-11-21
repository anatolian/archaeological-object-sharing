class RemoveCoordinateFromArtifacts < ActiveRecord::Migration
  def change
    remove_column :artifacts, :coordinate, :string
  end
end
