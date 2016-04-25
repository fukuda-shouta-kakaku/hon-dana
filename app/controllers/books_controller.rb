class BooksController < ApplicationController

  before_action :set_book, only: [:show]

  def search

  end

  def new
    @a = Tools::Scrap.new.hello
  end

  def create
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
