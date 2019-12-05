class CreateEmployeeProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_projects do |t|
      t.references :project, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
