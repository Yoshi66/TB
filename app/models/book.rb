class Book < ActiveRecord::Base
  has_many :relationships
  has_many :users, through: :relationships
  validates :course, presence: true
  validates :number, presence: true

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
        if search_result_json["totalItems"] != 0
          title = search_result_json['items'][0]['volumeInfo']['title']
          subtitle = search_result_json['items'][0]['volumeInfo']['subtitle']
          author = search_result_json['items'][0]['volumeInfo']['authors']
            if !author.nil?
              author[0] = author[0]+' '
              author = author.join("")
            end
          publisher = search_result_json['items'][0]['volumeInfo']['publisher']
          pub_date = search_result_json['items'][0]['volumeInfo']['publishedDate']
          thumbnail = search_result_json['items'][0]['volumeInfo']['imageLinks']['thumbnail']
        else
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
