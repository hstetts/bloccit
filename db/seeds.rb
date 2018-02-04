require 'random_data'

# Create Topics
15.times do
 Topic.create!(
   name:         RandomData.random_sentence,
   description:  RandomData.random_paragraph
 )
end
topics = Topic.all

# Create Posts
50.times do
#creating with a ! that instructs method to raise an error
 Post.create!(
#create random strings for title and body
   topic:  topics.sample,
   title:  RandomData.random_sentence,
   body:   RandomData.random_paragraph
 )
end
posts = Post.all

#Create Sponsored Posts
50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_integer
  )
end
sponsored_posts = SponsoredPost.all


# Create Comments
#call times on an integer and runs block a 100 times
100.times do
 Comment.create!(
#call sample on the array returned by Post.call, in order to pick
#random post to associate each comment with
#returns a random element from the array every time it is called
   post: posts.sample,
   body: RandomData.random_paragraph
 )
end

puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
