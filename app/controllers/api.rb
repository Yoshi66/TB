require 'open-uri'

  resp = open("http://isbndb.com/api/books.xml?access_key=#{YOUR_API_KEY}&results=details&index1=isbn&value1=#{params[:isbn]}")
  doc = Nokogiri.XML(resp.read)
  p doc
