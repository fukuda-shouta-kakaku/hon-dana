class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def new

  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'Post review'
    else
      flash[:danger] = 'Failed Post review'
    end

    params[:tags].each do |label|
      tag = Tag.find_or_create_by(label: label) unless label.empty?
      trel = TagRelationship.new(user_id: current_user.id, book_id: params[:review][:book_id], tag_id: tag.id)
      trel.save
    end
    redirect_to current_user
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :book_id, :body)
  end
end

