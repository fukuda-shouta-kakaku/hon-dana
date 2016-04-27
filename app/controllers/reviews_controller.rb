class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def new

  end

  def post 
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'Post review'
    else
      flash[:danger] = 'Failed Post review'
    end
    redirect_to :back
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'Post review'
    else
      flash[:danger] = 'Failed Post review'
    end

    tags = params[:tags] || []
    tags.each do |label|
      tag = Tag.find_or_create_by(label: label) unless label.empty?
      trel = TagRelationship.new(user_id: current_user.id, book_id: params[:review][:book_id], tag_id: tag.id)
      trel.save
    end
    redirect_to current_user
  end

  def update
    tags = params[:tags] || []
    rels = TagRelationship.where(user_id: current_user.id, book_id: params[:id])
    if tags.empty?
      rels.each { |rel| rel.destroy }
    else
      tag_ids = tags.map {|t| Tag.find_or_create_by(label: t).id }
      tag_ids.each {|id| TagRelationship.find_or_create_by(user_id: current_user.id, book_id: params[:id], tag_id: id)}
      rels.where.not(tag_id: tag_ids).where(user_id: current_user.id).each {|rel| rel.destroy }
    end
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

  def search
    @reviews = Review.search(params[:keywords])
  end

  private

  def update_params
    params.require(:review).permit(:body)
  end

  def review_params
    params.require(:review).permit(:user_id, :book_id, :body)
  end
end

