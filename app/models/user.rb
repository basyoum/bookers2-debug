class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #1対1のチャット機能
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms
  #閲覧数を表示
  has_many :view_counts, dependent: :destroy

  #グループ機能の作成
  has_many :group_users, dependent: :destroy


  #自分がフォローされる(被フォロー)側の関係性
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #被フォロー関係を通じて参照→自分がフォローしている人
  has_many :followers, through: :reverse_relationships, source: :follower

  #自分がフォローする側(与フォロー)の関係性
  has_many :relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  #与フォローの関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed


  #フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id:user_id)
  end
  #フォロー外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id:user_id).destroy
  end
  #フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect"
      User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      User.where("name LIKE?", "#{word}%")
    elsif search == "backward"
      User.where("name LIKE?", "%#{word}")
    else
      User.where("name LIKE?", "%#{word}%")
    end
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}




end
