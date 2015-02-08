class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.sort_by{|m| m.course}
    store = Array.new
    @storea = Array.new
    @books.each do |a|
      if store.include?"#{a.course},#{a.number}"
        logger.debug '///////////////////////////'
        logger.debug 'already stored'
        logger.debug '///////////////////////////'
      else
        @storea << a
        @store =  @storea.sort_by{|m| [m.course, m.number]}
        logger.debug store
        logger.debug 'first time to be output'
        logger.debug '///////////////////////'
      end
      store << "#{a.course},#{a.number}"
    end
    logger.debug @store
    logger.debug '..................................'
    @accounting = Book.where(course:'Accounting')
    @biology = Book.where(course:'Biology')
    @music = Book.where(course:'Music')
  end

  def show
  end

  def new
    @book = Book.new
    @books = Array.new(3){Book.new}
  end

  def edit
  end

  def create
    @user = current_user
    @books = params[:books].values.collect { |book| Book.new(book) }
    logger.debug @books
    respond_to do |format|
      if @books.all?(&:valid?)
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
