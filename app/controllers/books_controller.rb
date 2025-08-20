class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.order(created_at: :desc)
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params.to_h)
    if @book.save
      redirect_to @book, notice: "Book created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params.to_h)
      redirect_to @book, notice: "Book updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted successfully."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :url, :published_on, :status, author_ids: [])
  end
end
