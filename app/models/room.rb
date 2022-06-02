class Room < ApplicationRecord
  #チャットルーム
  has_many :chats
  has_many :users_room #1つのルームにいるユーザ数は2人のためhas_manyになる
end
