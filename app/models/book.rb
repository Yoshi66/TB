class Book < ActiveRecord::Base
  has_many :relationships
  has_many :users, through: :relationships
end
