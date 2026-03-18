require "rails_helper"

RSpec.describe Channel, type: :model do
  let(:user) do
    User.create!(name: "John Doe", email: "john@example.com", password: "password", role: "creator", age: 25)
  end

  it "is valid with valid attributes" do
    channel = Channel.new(name: "Tech Reviews", description: "Latest tech reviews and unboxings", owner: user)
    expect(channel).to be_valid
  end

  it "is not valid without a name" do
    channel = Channel.new(description: "Latest tech reviews and unboxings", owner: user)
    expect(channel).not_to be_valid
  end
  it "is not valid without a description" do
    channel = Channel.new(name: "Tech Reviews", owner: user)
    expect(channel).not_to be_valid
  end
  it "is not valid with duplicate name" do
    Channel.create(name: "Tech Reviews", description: "Latest tech reviews and unboxings", owner: user)
    channel = Channel.new(name: "Tech Reviews", description: "Another description", owner: user)
    expect(channel).not_to be_valid
  end

  it "is not valid with owner having role other than creator or admin" do
    user.update(role: "viewer")
    channel = Channel.new(name: "Tech Reviews", description: "Latest tech reviews and unboxings", owner: user)
    expect(channel).not_to be_valid
  end
end
