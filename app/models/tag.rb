class Tag < ActiveRecord::Base
  has_many :tag_relationships
end
