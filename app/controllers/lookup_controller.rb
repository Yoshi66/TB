class LookupController < ApplicationController
  before_action :authenticate_user!

  def quick_look
    @books = Array.new(3){Book.new}
  end

  def matchup
    logger.debug '/////////////////////////'
    logger.debug params
    logger.debug '/////////////////////////'
    tb0 = [params[:books]["0"]["isbn"]][0]
    tb1 = [params[:books]["1"]["isbn"]][0]
    tb2 = [params[:books]["2"]["isbn"]][0]
    tb0 = tb0.sub('-', '')
    tb1 = tb1.sub('-', '')
    tb2 = tb2.sub('-', '')
    send = [tb0,tb1,tb2]
    logger.debug send
    logger.debug '/////////////////////////'
    logger.debug '/////////////////////////'
    redirect_to lookup_result_path(isbn_info: send)
  end

  def result
    logger.debug params
    logger.debug '/////////////////////////'
    @book1 = Book.where(isbn: params[:isbn_info][0])
    @book2 = Book.where(isbn: params[:isbn_info][1])
    @book3 = Book.where(isbn: params[:isbn_info][2])
    @books = [@book1, @book2, @book3]
    logger.debug '/////////////////////////'
  end

  def hello
    logger.debug "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  end

end