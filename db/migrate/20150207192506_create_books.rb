class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :course
      t.integer :number

      t.timestamps
    end
  end
end
