class HondanaController < ApplicationController
  def index 
    @reviews = Review.includes(:book).includes(:user).limit(30).order("id desc")
  end
end
