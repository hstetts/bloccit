require 'rails_helper'

RSpec.describe Post, type: :model do

  #create new instance of the Post class
  #Upon first call within a spec, computes and stores the returned value
  #let(:post) { Post.create!(title: "New Post Title", body: "New Post Body")}

   let(:name) { RandomData.random_sentence }
   let(:description) { RandomData.random_paragraph }
   let(:title) { RandomData.random_sentence }
   let(:body) { RandomData.random_paragraph }
   #parent topic for post
   let(:topic) { Topic.create!(name: name, description: description) }
   #create a user to associate w/ a test post
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   #chained method creates a post for a given topic
   #associate user with post when we create the test post
   #associate post with topic via topic.posts.create!
   let(:post) { topic.posts.create!(title: title, body: body, user: user) }

   it { is_expected.to belong_to(:topic) }
   it { is_expected.to belong_to(:user) }

   it { is_expected.to validate_presence_of(:title) }
   it { is_expected.to validate_presence_of(:body) }
   it { is_expected.to validate_presence_of(:topic) }
   it { is_expected.to validate_presence_of(:user) }

   it { is_expected.to validate_length_of(:title).is_at_least(5) }
   it { is_expected.to validate_length_of(:body).is_at_least(20) }


  #test whether post has attributes named title and body
  #test whether post returns a non-nil value when post.title or post.body is called
  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end
end
