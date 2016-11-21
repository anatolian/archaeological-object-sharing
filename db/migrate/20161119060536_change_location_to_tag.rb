class ChangeLocationToTag < ActiveRecord::Migration
  def change
    rename_table :locations, :tags
  end
end
