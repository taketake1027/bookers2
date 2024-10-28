class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_create = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_url(@book), notice: "You have created the book successfully." # 詳細ページへリダイレクト
    else
      # エラーが発生した場合
      @user = current_user
      @books = Book.all
      flash.now[:alert] = @book.errors.full_messages.to_sentence # エラーメッセージを取得
      render :index # indexページを再レンダリング
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path, alert: "You are not authorized to edit this book."
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path, alert: "You are not authorized to update this book."
      return
    end

    if @book.update(book_params)
      flash[:notice] = "You have updated the book successfully."
      redirect_to book_path(@book) # 詳細ページへリダイレクト
    else
      flash[:alert] = "There was an error updating the book."
      puts @book.errors.full_messages # デバッグ用
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "You have deleted the book successfully."
      redirect_to books_path
    else
      flash[:alert] = "There was an error deleting the book."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
