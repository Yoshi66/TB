class Book < ActiveRecord::Base
  has_many :relationships
  has_many :users, through: :relationships

  def self.search(search)
    if search.present?
      where('isbn LIKE ?', "%#{search}%")
    else
      where(true)
    end
  end
end
