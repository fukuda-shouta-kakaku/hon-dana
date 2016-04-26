class Review < ActiveRecord::Base
  belongs_to :user_params
  belongs_to :book
end
