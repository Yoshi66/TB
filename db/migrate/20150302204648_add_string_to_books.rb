class AddStringToBooks < ActiveRecord::Migration
  def change
    remove_column :books, :isbn, :integer
    add_column :books, :isbn, :string
  end
end
