class ArtifactsTagsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :artifacts, :tags do |t|
      t.index [:artifact_id, :tag_id]
      t.index [:tag_id, :artifact_id]
    end
  end
end
