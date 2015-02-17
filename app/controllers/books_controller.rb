class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

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

  def create
    @user = current_user
    @books = params[:books].values.collect { |book| Book.new(book) }
    logger.debug @books
    book_container = Array.new
    #stock = 0
    @books.each do |a|
      #stock += 1
      #logger.debug stock
      if !a.isbn.nil?        #search_result = HTTParty.get("https://openlibrary.org/search.json?title=#{a.name.gsub(' ','+')}")
        logger.debug 'https://www.googleapis.com/books/v1/volumes?q=isbn:0201558025'
        search_result = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:0201558025")
        logger.debug '11111111111111111111111'
        search_result_json = JSON.parse(search_result.body)
        puts title = search_result_json['items'][0]['volumeInfo']['title']
        puts subtitle = search_result_json['items'][0]['volumeInfo']['subtitle']
        puts author = search_result_json['items'][0]['volumeInfo']['authors']
        puts publisher = search_result_json['items'][0]['volumeInfo']['publisher']
        puts pub_date = search_result_json['items'][0]['volumeInfo']['publishedDate']
          if a.course.present?
            book_container << a
          end
      end
    end
    #logger.debug book_container
    respond_to do |format|
      if book_container.all?(&:valid?)
        book_container.each do |a|
          @book = @user.books.create(course: a[:course], number: a[:number], name: a[:name], isbn: a[:isbn])
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
      params.require(:book).permit(:course, :number, :name, :isbn)
    end
end
