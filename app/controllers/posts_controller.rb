class PostsController < ApplicationController
  #use before_action filter to call the require_sign_in method before each of our controller actions
  #except show action
  before_action :require_sign_in, except: :show
  before_action :authorize_moderator, only: [:edit, :update, :destroy]

  #use a second before_action filter to check the role of a signed-in user.
  #If the current_user isn't authorized based on their role, we'll redirect them to the posts show view.
  before_action :authorize_user, except: [:show, :new, :create]

  def show
    #find the post that corresponds to the id in the params that was passed to  show and assign it to @post.
    #Unlike in the index method, in the show method, we populate an instance variable with a single post, rather than a collection of posts.
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    #create an instance variable, @post, and assign it to an empty post returned by Post.new
    @post = Post.new
  end

  #when user clicks save, create method is called.
  #unlike new, create does not have corresponding view
  #works behind the scenes to collect data and update DB. POST action.
  def create
    @topic = Topic.find(params[:topic_id])
    #assign a topic to post
    @post = @topic.posts.build(post_params)
    #assign @post.user in the same way we assigned @post.topic, to properly scope new post
    @post.user = current_user


    #if we successfully save Post to DB, display a success message using flash[:notice]
    #and redirect user to the route generated by @post. Redirecting to @post will direct user to the posts show view
    if @post.save

      #assign value to flash[:notice]. flash hash is a way to pass temporary values between actions
      #any value in flash will be available in next action an deleted
      flash[:notice] = "Post was saved."
      #change the redirect to use the nested post path
      redirect_to [@topic, @post]
    else
     #if not successfully saved to Post to DB, display error message
     #and render new view again
     flash.now[:alert] = "There was an error saving the post. Please try again."
     render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
     flash[:notice] = "Post was updated."
     #change the redirect to use the nested post path
     redirect_to [@post.topic, @post]
    else
     flash.now[:alert] = "There was an error saving the post. Please try again."
     render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    #call destroy on @post.
    #if successful, set a flash msg and redirect the user to the posts index view
    #if destroy fails, redirect user to the show view using render :show
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      #when a post is deleted, direct users to topic show view
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end


  #remember to add private methods to the bottom of the file. Any method defined below private, will be private.
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    post = Post.find(params[:id])
    #we redirect the user unless they own the post they're attempting to modify, or they're an admin.
    unless current_user == post.user || current_user.admin? || current_user.moderator?
       flash[:alert] = "You must be an admin to do that."
       redirect_to [post.topic, post]
    end
  end
end
