class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :name
      t.text :description
      t.string :coordinate

      t.timestamps null: false
    end
  end
end
