class Post < ApplicationRecord
  #allows a post instance to have many comments related
  #provides methods to allow us to retrieve comments belonging to a post
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  #Add the votes association to Post. allows us to call post.votes
  has_many :votes, dependent: :destroy
  #order all posts by their created_at date, in descending order,
  #with the most recent posts displayed first.
  default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    #Find the up votes for a post by passing value: 1 to where.
    #This fetches a collection of votes with a value of 1.
    #We then call count on the collection to get a total of all up votes.
    votes.where(value: 1).count
  end

  def down_votes
    #Find the down votes for a post by passing value: -1 to where
    #where(value: -1) fetches only the votes with a value of -1.
    #We then call count on the collection to get a total of all up votes.
    votes.where(value: -1).count
  end

  def points
    #Use ActiveRecord's sum method to add the value of all the given post's votes.
    #Passing :value to sum tells it what attribute to sum in the collection.
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
end
