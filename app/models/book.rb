class Book < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum:200}
  
  # likes method
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # search methods
  def self.looks(searchword, search)
    
    if search == "perfect"
      @book = Book.where("title LIKE?", searchword)
      
    elsif search == "forward"
      @book = Book.where("title LIKE?", searchword + "%")
      
    elsif search == "backward"
      @book = Book.where("title LIKE?", "%" + searchword)
      
    else
      @book = Book.where("title LIKE?", "%" + searchword + "%")
      
    end
    
  end
  
end
