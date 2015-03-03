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
    @tb0 = tb0.sub('-', '')
    @tb1 = tb1.sub('-', '')
    @tb2 = tb2.sub('-', '')
    @book1 = Book.where(isbn: @tb0)
    @book2 = Book.where(isbn: @tb1)
    @book3 = Book.where(isbn: @tb2)
    @books = [@book1, @book2, @book3]
  end

  def result
    logger.debug params
    isbn1 = params[:isbn0]
    isbn2 = params[:isbn1]
    isbn3 = params[:isbn2]
    logger.debug isbn1
    logger.debug isbn2
    logger.debug isbn3
  end
end