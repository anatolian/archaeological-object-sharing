class ArtifactsLocationsJoinTable < ActiveRecord::Migration
  def change
    drop_join_table :artifacts, :locations
  end
end
