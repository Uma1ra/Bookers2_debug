class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # follow/follower model associations via foreign keys
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  has_many :following_users, through: :follows, source: :follower
  has_many :follower_users, through: :followers, source: :follow
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

# user's profile_image
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # follow/follower methods
  def follow(user_id)
    follows.create(follower_id: user_id)
  end
  
  def unfollow(user_id)
    follows.find_by(follower_id: user_id).destroy
  end
  
  def following?(user)
    following_users.include?(user)
  end
  
  # search methods
  def self.looks(searchword, search)
    
    if search == "perfect"
      User.where("name LIKE?", searchword)
      
    elsif search == "forward"
      User.where("name LIKE?", searchword + "%")
      
    elsif search == "backward"
      User.where("name LIKE?", "%" + searchword)
      
    else
      User.where("name LIKE?", "%" + searchword + "%")
      
    end
    
  end
  
end
