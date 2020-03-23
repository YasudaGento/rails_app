Faker::Config.locale = :ja

puts "記事データのseed投入"
user_id_arr = User.pluck(:id).shuffle
date = DateTime.now
user_id_arr.each_with_index() do |_i, num|
  add_num = num + 1
  Article.create!(
    user_id: user_id_arr[num].to_i,
    title: Faker::Book.title,
    content: Faker::Lorem.characters(number: 300),
    created_at: date - add_num.day
  )
end