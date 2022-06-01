class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
<<<<<<< HEAD
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
  end

  def destroy
    BookComment.find(params[:id]).destroy
=======
    @comment = current_user.book_comments.new(book_comment_params)
    #comment = Book.new(book_comment_params)
    #comment.user_id = current_user.id 6行目はの省略
    @comment.book_id = book.id
    @comment.save
  end

  def destroy
   @comment = BookComment.find(params[:id])
   @comment.destroy
>>>>>>> topic16
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
