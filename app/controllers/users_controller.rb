class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @books = @user.books
      render "edit"
    end
  end

  def following
    @title = 'Follow Users'
    # @userにDBから取得したparams[:id]のuserを代入
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Follower Users'
    # @userにDBから取得したparams[:id]のuserを代入
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:notice] = "Not authorized!!"
      redirect_to user_path(current_user)
    end
  end
end
