class AddParamToBooks < ActiveRecord::Migration
  def change
    remove_column :books, :name, :string
    add_column :books, :title, :string
    add_column :books, :subtitle, :string
    add_column :books, :author, :string
    add_column :books, :publisher, :string
    add_column :books, :pub_date, :string
  end
end
