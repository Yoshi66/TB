class LookupController < ApplicationController
  before_action :authenticate_user!

  def quick_look
    @books = Array.new(3){Book.new}
  end

  def matchup
    logger.debug '/////////////////////////'
    logger.debug 'boooooooooooookkkkkkkkkkkkkk'
    logger.debug '/////////////////////////'
    tb0 = [params[:books]["0"]["isbn"]][0]
    tb1 = [params[:books]["1"]["isbn"]][0]
    tb2 = [params[:books]["2"]["isbn"]][0]
    @tb0 = tb0.sub('-', '')
    @tb1 = tb1.sub('-', '')
    @tb2 = tb2.sub('-', '')
    @book1 = Book.find_by(isbn: @tb0)
    @book2 = Book.find_by(isbn: @tb1)
    @book3 = Book.find_by(isbn: @tb2)
    logger.debug '/////////////////////////'
    logger.debug @book1
    logger.debug @book2
    logger.debug @book3
    logger.debug '/////////////////////////'
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
    logger.debug '.........................................'
    d = Book.where(isbn:isbn1)
    users1 = []
    d.each do |f|
      users1 << f.users.first unless !f.users.first.email.include? users1
      logger.debug '1111111111111111111111'
      p users1
      logger.debug '1111111111111111111111'
    end
    users = []
    users1.each do |t|
      if !t.books.where(isbn: isbn2).nil?
        users << t
      end
    end
    logger.debug '/////////////////////'
    p users
    logger.debug '/////////////////////'

  end
end