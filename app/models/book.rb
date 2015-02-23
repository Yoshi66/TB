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
end
