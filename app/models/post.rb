class Post < ApplicationRecord
  #allows a post instance to have many comments related
  #provides methods to allow us to retrieve comments belonging to a post
  belongs_to :topic
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true

end
