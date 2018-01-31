include 'random_data'

# Create Advertisements
10.times do
 Advertisement.create!(

   title: RandomData.random_sentence,
   copy: RandomData.random_paragraph,
   price: 10
 )
end

# Create Posts
50.times do
#creating with a ! that instructs method to raise an error
 Post.create!(
#create random strings for title and body
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

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

# Create Advertisements
