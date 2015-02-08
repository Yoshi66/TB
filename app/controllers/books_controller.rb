class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @accounting = Book.where(course:'Accounting')
    @biology = Book.where(course:'Biology')
    @music = Book.where(course:'Music')
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    @books = Array.new(3){Book.new}
    logger.debug @books
    logger.debug '///////////////////////////'
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create

    @user = current_user
    @books = params[:books].values.collect { |book| Book.new(book) }
    logger.debug @books
    respond_to do |format|
      if @books.all?(&:valid?)
        logger.debug '///////////////////////////'
        logger.debug @books[0][:course]
        logger.debug @books[1][:course]
        logger.debug @books[2][:course]
        logger.debug '///////////////////////////'
        @books.each do |a|
          @book = @user.books.create(course: a[:course], number: a[:number])
          @book.save
        end
        #@book = @user.books.build(book_params)
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:course, :number)
    end
end
