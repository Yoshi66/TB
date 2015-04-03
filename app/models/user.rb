class User < ActiveRecord::Base
  has_many :relationships
  has_many :books, through: :relationships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
