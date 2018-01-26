require 'rails_helper'

RSpec.describe Post, type: :model do

  #create new instance of the Post class
  #Upon first call within a spec, computes and stores the returned value
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body")}

  #test whether post has attributes named title and body
  #test whether post returns a non-nil value when post.title or post.body is called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
