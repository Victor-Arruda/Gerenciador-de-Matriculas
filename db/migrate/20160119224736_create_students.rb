class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :cpf
      t.string :rg
      t.date :birth_date
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
