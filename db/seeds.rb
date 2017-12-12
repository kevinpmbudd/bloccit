require 'random_data'

15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  Post.create!(
    topic: topics.sample,
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

10.times do
  Advertisement.create!(
    title: RandomData.random_word,
    copy: RandomData.random_sentence,
    price: 1 + rand(100)
  )
end

10.times do
  Question.create!(
    title: RandomData.random_title,
    body: RandomData.random_question,
    resolved: false
  )
end

puts "Seed Finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
