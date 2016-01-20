class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.decimal :price
      t.integer :period

      t.timestamps null: false
    end
  end
end
