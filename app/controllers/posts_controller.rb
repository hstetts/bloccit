class PostsController < ApplicationController
  def index
    #declare instance variable @posts and assign it to a collection
    #of Post objects using all method provided by ActiveRecord
    #all returns a collection of Post objects
    @posts = Post.all

    #iterate over posts and get index to update each 5th index with SPAM
    @posts.each_with_index do |post, index|
      if index % 5 == 0
       post.title = "SPAM"
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
