class UsersArtifactsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :artifacts do |t|
      # t.index [:user_id, :artifact_id]
      # t.index [:artifact_id, :user_id]
    end
  end
end
