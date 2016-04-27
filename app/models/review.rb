class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def self.search (keywords, **options)
    if options[:user_id]
      Review.eager_load(:book).where("books.title like ? and reviews.user_id = ?", "%#{keywords}%", options[:user_id]).order(id: :desc)
    else
      Review.eager_load(:book).where("books.title like ?", "%#{keywords}%").order(id: :desc)
    end
  end
end
