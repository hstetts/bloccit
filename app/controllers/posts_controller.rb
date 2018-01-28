class PostsController < ApplicationController
  def index
    #declare instance variable @posts and assign it to a collection
    #of Post objects using all method provided by ActiveRecord
    #all returns a collection of Post objects
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
