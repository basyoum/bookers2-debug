class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  #いいね1week多い順にする
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  #閲覧数を表示
  has_many :view_counts, dependent: :destroy



  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect"
      Book.where("title LIKE?", "#{word}")
    elsif search == "forward"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "backward"
      Book.where("title LIKE?", "%#{word}")
    else
      Book.where("title LIKE?", "%#{word}%")
    end
  end

  #本の投稿数を数える(今日.前日)
  scope :created_today, -> {where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> {where(created_at: 1.day.ago.all_day) }
  #本の投稿数を数える(今週.先週)
  scope :created_this_week, -> {where(created_at: Time.now.all_week(:saturday)) }
  scope :created_before_week, ->{where(created_at: 1.week.ago.all_week)}


  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
