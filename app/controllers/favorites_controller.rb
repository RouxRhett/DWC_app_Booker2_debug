class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #リダイレクト先を削除する
    #redirect_back(fallback_location:root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_back(fallback_location:root_path)
  end

  #特定の操作によって「ActionController::InvalidAuthenticityToken」が発生する。課題終了後要確認
end
