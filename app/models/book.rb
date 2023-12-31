class Book < ApplicationRecord

  has_one_attached :image
  belongs_to  :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  #応用課題8
  has_many :read_counts, dependent: :destroy


  validates :title,presence:true
  validates :body, presence:true, length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #応用課題５
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end


end
