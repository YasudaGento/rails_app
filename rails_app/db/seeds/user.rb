Faker::Config.locale = :ja

puts "ユーザーのseed投入"
User.create!(name: "安田 元斗", password: "Yg123456", email: "gennto@gmail.com")
100.times do |num|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "aBcDeFgH#{num}"
  )
end