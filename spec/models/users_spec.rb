require "rails_helper"

RSpec.describe User, :type => :model do
  it "can crate user with username and password" do

    lindeman = User.new(firstname: "Andy", lastname: "Lindeman", email: "al@gmail.com", password: "al123465")
    lindeman.skip_confirmation!
    lindeman.save!
    chelimsky = User.new(firstname: "David", lastname: "Chelimsky", email: "dc@gmail.com", password: "dc123465")
    chelimsky.skip_confirmation!
    chelimsky.save!

    expect(User.all.size).to eq(2)

  end
end