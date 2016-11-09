class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|

      t.timestamps null: false
    end
  end
end
