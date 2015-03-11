class LookupController < ApplicationController
  before_action :authenticate_user!

  def quick_look
    @books = Array.new(3){Book.new}
  end

  def matchup
    tb0 = [params[:books]["0"]["isbn"]][0]
    tb1 = [params[:books]["1"]["isbn"]][0]
    tb2 = [params[:books]["2"]["isbn"]][0]
    @tb0 = tb0.sub('-', '')
    @tb1 = tb1.sub('-', '')
    @tb2 = tb2.sub('-', '')
    @book1 = Book.find_by(isbn: @tb0)
    @book2 = Book.find_by(isbn: @tb1)
    @book3 = Book.find_by(isbn: @tb2)
    @books = [@book1, @book2, @book3]
  end


  def i(object,container,isbn_number)
    if !object.nil?
      object.each do |a|
        a.books.each do |b|
          if b.isbn == isbn_number
            container << a
          end
        end
      end
    end
  end

  def  contain_users(object, container)
    if !object.nil?
      object.each do |a|
        container << a.users.first
      end
    else
      return false
    end
  end

  def result
    @isbn1 = params[:isbn0]
    @isbn2 = params[:isbn1]
    @isbn3 = params[:isbn2]
    logger.debug '.........................................'
    books_1 = Book.where(isbn:@isbn1)
    books_2 = Book.where(isbn:@isbn2)
    books_3 = Book.where(isbn:@isbn3)
    users_1 = []
    users_2 = []
    users_3 = []
    users_4 = []
    users_5 = []
    users_6 = []
    @result_1 = []
    @result_2 = []
    @result_3 = []
    if !contain_users(books_1, users_1).nil?
      #1 & 2
      i(users_1,users_2,@isbn2)
      logger.debug users_2
      logger.debug '2222222222222222222'
      if users_2 != [] #test 1 & 2
        #1&2 matched
        i(users_2,users_3,@isbn3)
        logger.debug users_3
        logger.debug '333333333333333333'
        if users_3 != []#test 1 & 2 & 3
          #1&2&3 matched
          @result_1 = users_3.first
          logger.debug 'conclusion 1&2&3'
        else
          #1&2 matched but not 3
          @result_1 = users_2.first
          @result_2 = books_3.first.users.first
          puts @result_1
          logger.debug 'conclusion 1&2 + 3'
        end
      else
        #1&2 matched
        #test 1 & 3
        i(users_1,users_4,@isbn3)
        logger.debug users_4
        logger.debug '444444444444444'
        if users_4 == []#1&3 doesn't match
          #test 1 & 3 does not match
          if !contain_users(books_2, users_5).nil? #books_2 exist?
            i(users_5,users_6,@isbn3)
            if users_6 == [] #test 2 & 3
              #nothing match
              logger.debug 'nothing hit!!!!!!!!!!!!'
              @result_1 = books_1.first.users.first
              @result_2 = books_2.first.users.first
              @result_3 = books_3.first.users.first
              redirect_to books_path
            else
              #2&3 matched
              @result_1 = books_1.first.users.first
              @result_2 = users_6.first
              logger.debug 'conclusion 1 + 2&3'
            end
          else
            if !books_3.nil?
              @result_1 = books_1.first.users.first
              #users_2 does not exist
              @result_2 = books_3.first.users.first
              logger.debug 'conclusion 1&3 + x2'
            else
              @result_1 = books_1.first.users.first
              #users_2 does not exist
              #users_3 does not exist
              logger.debug 'conclusion 1 + x2 x3'
            end
          end
        else
          #1&3 match
          @result_1 = users_4.first
          @result_2 = books_2.first.users.first
          logger.debug 'conclusion 1&3 + 2'
        end
      end

    else
      #1 & 2 does not macth
      logger.debug '2222222222-----------5555555'
      if !contain_users(books_2, users_5).nil? #2 exists?
        i(users_6,users_5,@isbn3)
        logger.debug users_5
        logger.debug '555555555555555555555'
        if users_5 == []#test 2&3 match?
          #2&3 does not match
          contain_users(books_1,users_6,isbn3)
          if users_6 == []#test 1&3
            #1&3 does not match
            logger.debug '22222nothing hit!!!!!!!!!!!!'
            redirect_to books_path
          else
            #1&3 match
            @result_1 = users_6
            @result_2 = books_2.first.users.first
            logger.debug 'conclusion 1&3 + 2'
          end
        else
          #2&3 match
          @result_1 = users_5.first
          @result_1 = books_2.first.users.first
          logger.debug 'conclusion 2&3 + 1'
        end
      else
        #2 doesn't exist
        if !books_3.nil?
          @result_3 = books_3.first.users.first
          return 'book 1 and 2 could not be found in our database'
        end
      end
    end
    logger.debug '11111111111111'
    puts @result_1
    logger.debug '2222222222222222'
    puts @result_2
    logger.debug '33333333333333333'
    logger.debug @result_3
    logger.debug 'finalfinal'
    @result = [@result_1, @result_2, @result_3]
    #redirect_to books_path
  end
end