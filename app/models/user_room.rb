class UserRoom < ApplicationRecord
  #ユーザとチャットルームの関連付けの定義(中間テーブル)
  #外部キーとしてuser_idとroom_idを持つ
  #ユーザとルームの紐付けを行う:
  #→ユーザにどのroom_idが紐づいているか、ルームにどのuser_idが紐づいているか
  belongs_to :user
  belongs_to :room
end
