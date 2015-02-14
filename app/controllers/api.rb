require 'open-uri'
class ApiController < ApplicationController
  def searchbook
     resp = open("http://isbndb.com/api/books.xml?access_key=#{YOUR_API_KEY}&results=details&index1=isbn&value1=#{params[:isbn]}")
     doc = Nokogiri.XML(resp.read)
     p doc
     # ... process response here
  end
end