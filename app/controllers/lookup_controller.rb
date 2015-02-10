class LookupController < ApplicationController

  def quick_look
    @books = Array.new(3){Book.new}
  end

  def matchup
    logger.debug '/////////////////////////'
    logger.debug params
    logger.debug '/////////////////////////'
    tb0 = [params[:books]["0"]["course"],params[:books]["0"]["number"]]
    tb1 = [params[:books]["1"]["course"],params[:books]["1"]["number"]]
    tb2 = [params[:books]["2"]["course"],params[:books]["2"]["number"]]
    logger.debug tb0
    logger.debug tb1
    logger.debug tb2
    sc1 = Book.where(course: tb0[0], number: tb0[1])
    logger.debug sc1
    #sc2 = sc1.find_by(course: tb1[0], number: tb1[1])
    #sc3 = sc2.find_by(course: tb2[0], number: tb2[1])
    logger.debug '/////////////////////////'
    #logger.debug user
    #logger.debug sc2.to_a
    #logger.debug sc3.to_a
    logger.debug '/////////////////////////'
    redirect_to books_url
  end
end