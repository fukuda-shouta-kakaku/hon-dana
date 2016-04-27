class Book < ActiveRecord::Base
  has_many :reviews
  has_many :review_users, through: :reviews, source: :user

  has_many :tag_relationships
  has_many :tags, through: :tag_relationships, source: :tag

end
