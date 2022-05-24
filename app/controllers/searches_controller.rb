class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range] #検索モデル

    if @range == "User"
      @users = User.looks(params[:search], params[:word]) #検索方法、検索ワード
      redirect_to search_path(@range)
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
