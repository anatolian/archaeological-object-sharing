
    # t.string   "name"
    # t.text     "description"
    # t.datetime "created_at",  null: false
    # t.datetime "updated_at",  null: false
    # t.float    "longitude"
    # t.float    "latitude"
    # t.text     "filepath"

require "rails_helper"

RSpec.describe Tag, :type => :model do
  it "orders by last name" do

    ancientArtifact = Artifact.new(name: "shining stone", description: "this is a golden stone", longitude: 102.1, latitude: 35.7)
    ancientArtifact.save!

    expect(Artifact.first.name).to eq("shining stone")
    
  end
end