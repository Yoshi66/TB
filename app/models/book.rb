class Book < ActiveRecord::Base
  has_many :relationships
  has_many :users, through: :relationships
  validates :course, presence: true, on: :isbn
  validates :number, presence: true
  validates :price, presence: true

  def self.search(search)
    if search.present?
      where('isbn LIKE ?', "%#{search}%")
    else
      where(true)
    end
  end



  def self.api_search(isbn)
        search_result = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
        search_result_json = JSON.parse(search_result.body)
        check = search_result_json['totalItems']
        logger.debug check
        if check != 0
          logger.debug 'pass1'
          title = search_result_json['items'][0]['volumeInfo']['title']
          subtitle = search_result_json['items'][0]['volumeInfo']['subtitle'] unless !subtitle.nil?
          author = search_result_json['items'][0]['volumeInfo']['authors'] unless !author.nil?
            if !author.nil?
              author[0] = author[0]+' '
              author = author.join("")
            end
          publisher = search_result_json['items'][0]['volumeInfo']['publisher'] unless !publisher.nil?
          pub_date = search_result_json['items'][0]['volumeInfo']['publishedDate'] unless !pub_date.nil?
          thumbnail = search_result_json['items'][0]['volumeInfo']['imageLinks']['thumbnail'] unless !thumbnail.nil?
        else
          logger.debug 'pass2'
          title = nil
          subtitle = nil
          author = nil
          publisher = nil
          pub_date = nil
          thumbnail = nil
          #search_result = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:isbn")
          #search_result_json = JSON.parse(search_result.body)
          #title = search_result_json['items'][0]['volumeInfo']['title']
          #subtitle = search_result_json['items'][0]['volumeInfo']['subtitle']
          #author = search_result_json['items'][0]['volumeInfo']['authors']
          #logger.debug 'auuuuuuuuuuuuuuuuuuuuuuuu'
          #logger.debug author
          #logger.debug 'auuuuuuuuuuuuuuuu'
          #author[0] = author[0]+' '
          #author = author.join("")
          #publisher = search_result_json['items'][0]['volumeInfo']['publisher']
          #pub_date = search_result_json['items'][0]['volumeInfo']['publishedDate']
          #thumbnail = search_result_json['items'][0]['volumeInfo']['imageLinks']['thumbnail']
        end
        return title, subtitle, author, publisher, pub_date, thumbnail
  end
end
