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
    @books.each do |a|
      if !a.isbn.nil?
      #search_result = HTTParty.get("https://openlibrary.org/search.json?title=#{a.name.gsub(' ','+')}")
        #is the first letter of number is 0, it will be deleted. saerch for the reason
        search_result = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{a.isbn}")
        logger.debug '11111111111111111111111'
        logger.debug "#{a.isbn}"
        logger.debug '1118356853'
        search_result_json = JSON.parse(search_result.body)
        title = search_result_json['items'][0]['volumeInfo']['title']
        logger.debug title.class
        subtitle = search_result_json['items'][0]['volumeInfo']['subtitle']
        author = search_result_json['items'][0]['volumeInfo']['authors']
        author = author.join("")
        publisher = search_result_json['items'][0]['volumeInfo']['publisher']
        pub_date = search_result_json['items'][0]['volumeInfo']['publishedDate']
        @user.books.create(course: a[:course], number: a[:number], isbn: a[:isbn], title: title, subtitle: subtitle, author: author, publisher: publisher, pub_date: pub_date)
        book_container << a
      end
    end
    respond_to do |format|
      if book_container.all?(&:valid?)
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
      params.require(:book).permit(:course, :number, :isbn)
    end
end
