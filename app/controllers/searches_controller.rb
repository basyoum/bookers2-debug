class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range] #検索モデル
    @word = params[:word] #検索ワード
    @search = params[:search] #検索方法

    if @range == "user"
      @records = User.looks(@search, @word) #検索方法、検索ワード
    elsif @range == "book"
      @records = Book.looks(@search, @word)
    elsif @range == "tag"
      @records = Tag.search_books_for(@search, @word)
    end
  end
end
