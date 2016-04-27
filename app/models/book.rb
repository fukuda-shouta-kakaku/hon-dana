class Book < ActiveRecord::Base
  has_many :reviews
  has_many :review_users, through: :reviews, source: :user

  has_many :tag_relationships
  has_many :tags, through: :tag_relationships, source: :tag

  def get_tags_per_user(user)
    tag_relationships.where(user_id: user.id).map(&:tag)
  end

  has_many :users, through: :reviews
end
