class BooksController < ApplicationController

  before_action :set_book, only: [:show]

  def new

  end

  def create
    @scraped = Tools::Scrape.new(params[:search]).get_params
    @book = Book.find_by(amazon_id: @scraped[:amazon_id])
    @book = Book.new(@scraped)
    if @book.save

    puts @scraped
  end


  def destroy
  end

  def show
  end


  private

  def set_book
    @book = Book.find(params[:id])
  end

end
