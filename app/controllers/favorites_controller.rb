class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
<<<<<<< HEAD
    favorite = current_user.favorites.new(book_id:book.id)
    favorite.save
=======
    @favorite = current_user.favorites.new(book_id:book.id)
    @favorite.save
    render 'create'
>>>>>>> topic16
  end

  def destroy
    book = Book.find(params[:book_id])
<<<<<<< HEAD
    favorite = current_user.favorites.find_by(book_id:book.id)
    favorite.destroy
=======
    @favorite = current_user.favorites.find_by(book_id:book.id)
    @favorite.destroy
    render 'destroy'
>>>>>>> topic16
  end
end
