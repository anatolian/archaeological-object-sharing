class ArtifactsLocationsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :artifacts, :locations do |t|
      # t.index [:artifact_id, :location_id]
      # t.index [:location_id, :artifact_id]
    end
  end
end
