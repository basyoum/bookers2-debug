class Chat < ApplicationRecord
  #チャット
  belongs_to :user
  belongs_to :room
end
