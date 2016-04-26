class HondanaController < ApplicationController
  def index 
    @books = Book.all;
  end
end
