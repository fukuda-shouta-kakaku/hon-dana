class ReviewsController < ApplicationController

  def new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'Post review'
    else
      flash[:danger] = 'Failed Post review'
    end
    redirect_to current_user
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :book_id, :body)
  end
end

