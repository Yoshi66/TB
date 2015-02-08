class LookupController < ApplicationController

  def quick_look
    @books = Array.new(3){Book.new}
  end

  def matchup
    logger.debug '/////////////////////////'
    logger.debug params
    logger.debug '/////////////////////////'
    redirect_to books_url
  end
end