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
  post = Post.create!(
  #create random strings for title and body
     user:   users.sample,
     topic:  topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )

   #Update the time a post was created. This makes our seeded data more realistic.
   post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
   #Create between one and five votes for each post. [-1, 1].sample randomly creates either an up vote or a down vote.
   rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Comments
#call times on an integer and runs block a 100 times
100.times do
 Comment.create!(
#call sample on the array returned by Post.call, in order to pick
#random post to associate each comment with
#returns a random element from the array every time it is called
   user: users.sample,
   post: posts.sample,
   body: RandomData.random_paragraph
 )
end

# Create an admin user
admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )

 # Create a member
 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
