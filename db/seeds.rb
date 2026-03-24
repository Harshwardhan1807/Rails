require "faker"

channels_data = [
  { name: "TechVerse Official", description: "Latest updates, reviews, and deep dives into the world of technology and gadgets." },
  { name: "CodeCraft TV", description: "Programming tutorials, Rails tips, React guides, and real-world development projects." },
  { name: "PixelPulse Gaming", description: "Gameplay walkthroughs, live streams, and esports highlights from trending games." },
  { name: "Startup Stories", description: "Inspiring journeys of entrepreneurs, founders, and innovative startups." },
  { name: "Fitness Freaks India", description: "Workout routines, diet plans, and practical fitness advice for beginners and pros." },
  { name: "Finance Fundamentals", description: "Personal finance, investing basics, stock market insights, and wealth building strategies." },
  { name: "Travel Trails TV", description: "Exploring hidden gems, travel guides, and budget-friendly trip experiences." },
  { name: "Movie Buff Central", description: "Honest movie reviews, trailer breakdowns, and entertainment news." },
  { name: "Science Simplified", description: "Breaking down complex science concepts into simple and engaging explanations." },
  { name: "Digital Dynasty", description: "Content about online business, freelancing, and building digital income streams." },

  # Hindi Channels
  { name: "Tech Duniya Hindi", description: "Technology news, mobile reviews, aur gadgets ki puri jankari Hindi mein." },
  { name: "Code Sikho", description: "Programming aur web development tutorials simple Hindi language mein." },
  { name: "Rozana Vlogs", description: "Daily life vlogs, challenges, aur relatable Indian lifestyle content." },
  { name: "Filmy Adda", description: "Bollywood updates, movie reviews, aur masaledar entertainment gossip." },
  { name: "Share Bazaar Hindi", description: "Stock market analysis, trading strategies, aur investment tips Hindi mein." },
  { name: "Sehat Aur Fitness", description: "Ghar par exercise, healthy diet tips, aur weight loss guidance Hindi mein." },
  { name: "Yatra Mitra", description: "India ke tourist places, travel hacks, aur budget travel guides Hindi mein." },
  { name: "Gyaan Ki Baatein", description: "Educational videos, facts, aur competitive exam preparation content." },
  { name: "Khana Khazana Desi", description: "Indian recipes, street food reviews, aur cooking tutorials Hindi mein." },
  { name: "Motivation Mantra", description: "Inspirational speeches, success stories, aur self-improvement guidance." },

  # Mixed / Niche
  { name: "Anime Universe India", description: "Anime reviews, manga discussions, and fan theories for Indian audience." },
  { name: "Auto Arena", description: "Car and bike reviews, comparisons, and automotive industry news." },
  { name: "Photography Pro", description: "Camera tips, editing tutorials, and creative photography techniques." },
  { name: "The Debug Zone", description: "Fixing bugs, explaining errors, and solving real coding problems." },
  { name: "Healthy Habits Hub", description: "Simple habits, productivity tips, and mental wellness strategies." },
  { name: "Crypto Corner India", description: "Cryptocurrency news, blockchain basics, and market updates." },
  { name: "History Vault", description: "Untold stories, historical events, and fascinating facts from the past." },
  { name: "Comedy Junction", description: "Stand-up clips, funny sketches, and relatable comedy content." },
  { name: "Artistic Souls Studio", description: "Drawing, painting, and digital art tutorials for creative minds." },
  { name: "Data Decode", description: "Data science, AI concepts, and machine learning explained simply." },
]

begin
  if User.count < 10 || Channel.count < 20
    puts "Seeding database with sample users..."

    admin = User.find_or_initialize_by(email: "admin@example.com")
    admin.name = "Admin"
    admin.age = 30
    admin.role = "admin"
    admin.password = "admin@example.com"
    admin.password_confirmation = "admin@example.com"
    admin.save!

    9.times do
      email = Faker::Internet.unique.email
      user = User.find_or_initialize_by(email: email)
      user.name = Faker::Name.first_name
      user.age = rand(18..60)
      user.role = ["creator", "viewer"].sample
      user.password = "Password@123"
      user.password_confirmation = "Password@123"
      user.save!
    end

    puts "Created #{User.count} users"

    puts "Seeding database with sample channels..."

    user_ids = User.where(role: "creator").pluck(:id)

    channels_data.each do |channel|
      Channel.find_or_create_by!(
        name: channel[:name],
        description: channel[:description],
        owner_id: user_ids.sample,
      )
    end

    puts "Created #{Channel.count} channels"
  end
rescue => e
  puts "Error seeding database: #{e.message}"
end
