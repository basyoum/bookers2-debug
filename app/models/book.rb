class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  #いいね1week多い順にする
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  #閲覧数を表示
  has_many :view_counts, dependent: :destroy
  #投稿の時にカテゴリタグを追加する
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags



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

  #7日分の投稿データ取得
  scope :created_days_ago, ->(n) {where(created_at: n.days.ago.all_day)}
  #7日分の投稿を取り出す
  #def self.before_week_count
    #(1..6).map {|n| created_days_ago(n).count}.reverse
  #end

  #投稿にタグをつける(更新機能)
  def save_tags(savebook_tags)
    #現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #今bookが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - savebook_tags
    #今回保存されたものと現在の差を新しいタグとする。新しいタグは保存。
    new_tags = savebook_tags - current_tags

    #Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    #Create new taggings:
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name:new_name)
      #配列に保存
      self.tags << book_tag
    end
  end

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
