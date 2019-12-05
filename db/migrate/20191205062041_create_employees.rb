class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.text :description
      t.string :company_name

      t.timestamps
    end
  end
end
