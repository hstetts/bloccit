class Post < ApplicationRecord
  #allows a post instance to have many comments related
  #provides methods to allow us to retrieve comments belonging to a post
  belongs_to :topic
  has_many :comments, dependent: :destroy
end
