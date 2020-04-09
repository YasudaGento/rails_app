Faker::Config.locale = :ja

puts "ユーザーのseed投入"
User.create(name: "安田 元斗", password: "123456789", email: "gennto@gmail.com")
100.times do 
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: SecureRandom.alphanumeric(10)
  )
end