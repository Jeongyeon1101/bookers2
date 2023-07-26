class BooksController < ApplicationController

  def index
    @books = Book.all
    @user = current_user
    @book_list = Book.new
  end

  def create
    @book_list = Book.new(book_params)
    @book_list.user_id = current_user.id
    if @book_list.save
      redirect_to book_path(@book_list.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_list = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
