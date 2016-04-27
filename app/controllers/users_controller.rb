class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :search]
  before_action :set_user, only: [:show]

  def show
    @reviews = Review.includes(:book).includes(:user).where("reviews.user_id =?",@user.id).limit(30).order("id desc")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # FIXME: Create session for the sake of redirecting
      session[:user_id] = @user.id

      flash[:success] = "Welcome to hon-dana!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Updating profile succeeded."
      redirect_to @user
    else
      flash[:danger] = "Updating profile failed..."
      render 'edit'
    end
  end

  def search
    @reviews = Review.search(params[:keywords], user_id: @user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                        :description, :password_confirmation)
  end

  def set_user
    @user = User.find_by_id(params[:id]) \
      or render text: "404", status: 404
  end
end
