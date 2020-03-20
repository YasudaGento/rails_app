Faker::Config.locale = :ja

puts "記事データのseed投入"
user_id_arr = User.pluck(:id).shuffle
user_id_arr.each.with_index(1) do |i, num|
  Article.create!(
    user_id: user_id_arr[num].to_i,
    title: Faker::Book.title,
    content: Faker::Lorem.characters(number: 300)
  )
end