class User < ApplicationRecord


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #register an inline callback directly after the before_save callback.

  before_save { self.email = email.downcase if email.present? }
  #shorthand for  self.role = :member if self.role.nil?
  before_save { self.role ||= :member }

  #Ruby's validates function to ensure that name is present and has a maximum and minimum length.
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  #validate password with two separate validations:
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  #validate that email is present, unique, case insensitive, has a minimum length,
  #has a maximum length, and that it is a properly formatted email address.
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }


   has_secure_password

   enum role: [:member, :admin]

   #Takes a post object and uses where to retrieve user's favorites with a post_id that matches post.id.
   #If user has favorited post it will return an array of one item.
   def favorite_for(post)
     favorites.where(post_id: post.id).first
   end

   def avatar_url(size)
     gravatar_id = Digest::MD5::hexdigest(self.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end
end
