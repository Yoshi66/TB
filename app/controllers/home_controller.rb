class HomeController < ApplicationController
  def index
    course = ["Accounting", "Finance", "Marketing","Supply", "Management","Agriculture","Communications","Information Sciences"]
    i = 0
    while i < 10
      item = course.sample(2)
      logger.debug course
      logger.debug item
      i += 1
    end
  end

  def about
  end
end
