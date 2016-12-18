require "rails_helper"

RSpec.describe Tag, :type => :model do
  it "orders by last name" do

    tag = Tag.new(name: "tag for location", description: "Town 311")
    tag.save!

    expect(Tag.first.name).to eq("tag for location")
    
  end
end