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

  def update 
    @review = current_user.reviews.find_by(id: params[:id])
    return redirect_to root_url if @review.nil? 
    @review.update_attributes(:body => params[:body])
    render :text => @review.body, :layout => false and return
  end

  def destroy
    @review = current_user.reviews.find_by(id: params[:id])
    return redirect_to root_url if @review.nil?
    @review.destroy
    render :text => "0", :layout => false and return
  end

  private

  def update_params
    params.require(:review).permit(:body)
  end

  def review_params
    params.require(:review).permit(:user_id, :book_id, :body)
  end
end

