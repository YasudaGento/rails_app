Faker::Config.locale = :ja

puts "ユーザーのseed投入"
100.times do 
  User.create!(
    name: Faker::Name.name,
    mail: Faker::Internet.email,
    other_mail: Faker::Internet.email,
    password: SecureRandom.alphanumeric(10)
  )
end