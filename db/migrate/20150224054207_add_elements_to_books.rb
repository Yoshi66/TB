class AddElementsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :price, :integer
    add_column :books, :comment, :text
    add_column :books, :condition, :string
    add_column :books, :professor, :string
    add_column :books, :thumbnail, :string
  end
end
