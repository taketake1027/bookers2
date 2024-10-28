class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    @book = Book.new

    if user_signed_in?
      @current_user = current_user
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = current_user
  end

  def update
    if current_user == @user

      if @user.update(user_params)
        redirect_to @user, notice: 'You have updated user successfully.'
      else
        render :edit
      end
    else
      redirect_to @user, alert: 'You are not authorized to update this user.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
