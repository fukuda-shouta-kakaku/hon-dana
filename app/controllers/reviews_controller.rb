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
    redirect_to current_user
  end

  def search
    @reviews = Review.search(params[:keywords])
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :book_id, :body)
  end
end

