class Book < ActiveRecord::Base
  has_many :reviews
  has_many :review_users, through: :reviews, source: :user

  has_many :tag_relationships
  has_many :tags, through: :tag_relationships, source: :tag

  def get_tag_list_per_user(user)
    TagRelationship.where(user_id: 1).map {|r| r.tag }
  end
end
