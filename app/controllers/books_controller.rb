class BooksController < ApplicationController

  before_action :set_book, only: [:show]

  def create
    scraped = Tools::Scrape.new(params[:search])
    unless scraped.success
      @msg = 'failed get book info'
      render 'shared/error_ajax'
      return
    end
    parameter = scraped.get_params

    @book = Book.find_by(amazon_id: parameter[:amazon_id])
    if current_user.review_books.include?(@book)
      @msg = 'already exist review'
      render 'shared/error_ajax'
      return
    end

    unless @book
      @book = Book.new(parameter)
      unless @book.save
        @msg = 'faile create book'
        render 'shared/error_ajax'
        return
      end
    end
    @review = Review.new
  end


  def destroy
  end

  def show
    @book = Book.find_by_id(params[:id]) \
      or render text: "404", status: 404
    @reviews = @book.reviews.order("id desc");
  end


  private

  def set_book
    @book = Book.find(params[:id])
  end

end
