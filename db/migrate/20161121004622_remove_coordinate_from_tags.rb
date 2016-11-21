class RemoveCoordinateFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :coordinate, :string
  end
end
