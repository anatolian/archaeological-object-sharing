require "rails_helper"

RSpec.describe Tag, :type => :model do
  it "orders by last name" do

    bestgroup = Group.new(name: "best group")
    bestgroup.save!

    expect(Group.first.name).to eq("best group")
    
  end
end