require 'random_data'

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

post = Post.find_or_create_by!(
  title: "Unique Title 1",
  body: "Unique Body 1"
)

Comment.find_or_create_by!(
  post: post,
  body: "Unique Comment Body 1"
)

puts "Seed Finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
