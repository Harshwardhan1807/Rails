require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password", role: "viewer", age: 25)
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(email: "john@example.com", password: "password", role: "viewer", age: 25)
    expect(user).not_to be_valid
  end

  it "is not valid when age is less than or equal to 5" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password", role: "viewer", age: 5)
    expect(user).not_to be_valid
  end

  it "is not valid with duplicate email" do
    User.create(name: "John Doe", email: "john@example.com", password: "password", role: "viewer", age: 25)
    user = User.new(name: "Jane Doe", email: "john@example.com", password: "password", role: "viewer", age: 25)
    expect(user).not_to be_valid
  end
end
