class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @books = Book.search(params[:search])
    @book_sort = Book.all.sort_by{|m| m.course}
    store = Array.new
    @tstore = Array.new
    @book_sort.each do |a|
      if store.include?"#{a.course},#{a.number}"
      else
        @tstore << a
        @store =  @tstore.sort_by{|m| [m.course, m.number]}
      end
      store << "#{a.course},#{a.number}"
    end
  end

  def show
  end

  def new
    @book = Book.new
    @books = Array.new(3){Book.new}
  end

  def edit
  end

  def search
    logger.debug '//////search///////////'
    @book = Book.new(book_params)
    @book.isbn = book_params[:isbn].sub('-', '')
    logger.debug @book.isbn
    logger.debug '/////////////////////'
    if !@book.isbn.nil?
        logger.debug 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'
        stock = Book.api_search(@book.isbn)
        #subtitle = Book.api_search(@book.isbn)[1]
        #author = Book.api_search(@book.isbn)[2]
        #publisher = Book.api_search(@book.isbn)[3]
        #pub_date = Book.api_search(@book.isbn)[4]
        #thumbnail = Book.api_search(@book.isbn)[5]
        logger.debug 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'
    end
      if stock.nil?
        redirect_to books_not_found_path
      else
      redirect_to books_isbn_path(course: '', number: '', isbn: @book.isbn, title: stock[0], subtitle: stock[1], author: stock[2], publisher: stock[3], pub_date: stock[4], thumbnail: stock[5])
      end
  end

  def isbn
    @book = Book.new(isbn: params[:isbn], title: params[:title], subtitle: params[:subtitle], author: params[:author], publisher: params[:publisher], pub_date: params[:pub_date], thumbnail: params[:thumbnail])
    logger.debug @book.isbn
    logger.debug params
  end

  def not_found
  end

  def create
    @user = current_user
    @user.books.create(book_params)
    respond_to do |format|
      if Book.last.isbn = book_params[:isbn]
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
      params.require(:book).permit(:course, :number, :isbn, :title, :subtitle, :author, :publisher, :pub_date, :price, :comment, :condition, :professor, :thumbnail)
    end
end
