require 'random_data'

# Create Users
5.times do
 User.create!(
# #3
 name:     RandomData.random_name,
 email:    RandomData.random_email,
 password: RandomData.random_sentence
 )
end
users = User.all

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
   user:   users.sample,
   topic:  topics.sample,
   title:  RandomData.random_sentence,
   body:   RandomData.random_paragraph
 )
end
posts = Post.all

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

user = User.first
user.update_attributes!(
   email: 'hstetts@gmail.com',
   password: 'htest1'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
