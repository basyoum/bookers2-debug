class BookComment < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user
  belongs_to :book
=======
  belongs_to :book
  belongs_to :user

  validates :comment, presence: true
>>>>>>> topic9
end
