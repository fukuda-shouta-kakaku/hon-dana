class Book < ActiveRecord::Base
  has_many :reviews
  has_many :review_users, through: :reviews, source: :user
end
