require "faker"

begin
  puts "Seeding database with sample users..."
  User.create!(
    name: "Admin",
    email: "admin@example.com",
    password: "Password@123",
    age: 30,
    role: "admin",
  )
  9.times do
    User.create!(
      name: Faker::Name.first_name_neutral,
      email: Faker::Internet.unique.email,
      password: "Password@123",
      age: rand(18..60),
      role: ["creator", "viewer"].sample,
    )
  end
  puts "Created #{User.count} users"

  puts "Seeding database with sample channels..."
  user_ids = User.where(role: "creator").pluck(:id)
  suffixes = ["Official", "TV", "Gaming", "Vlogs", "Music", "Studio"]
  10.times do
    Channel.create!(
      name: "#{Faker::Internet.unique.username} #{suffixes.sample}",
      description: Faker::Lorem.sentence,
      owner_id: user_ids.sample,
    )
  end
  puts "Created #{Channel.count} channels"
rescue => e
  puts "Error seeding database: #{e.message}"
end
