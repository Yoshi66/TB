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
    logger.debug tb0
    logger.debug tb1
    logger.debug tb2
    tb0 = tb0.sub('-', '')
    tb1 = tb1.sub('-', '')
    tb2 = tb2.sub('-', '')
    book1 = Book.api_search(tb0)
    book2 = Book.api_search(tb1)
    book3 = Book.api_search(tb2)
    sc1 = Book.where(course: tb0[0], number: tb0[1])
    logger.debug '/////////////////////////'
    logger.debug book1
    logger.debug book2
    logger.debug book3
    logger.debug '/////////////////////////'
    redirect_to lookup_result_path(course: "a")
  end

  def result
  end
end