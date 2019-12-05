class Employee < ApplicationRecord

	validates :name, :company_name, presence: true

	has_many :employee_projects, dependent: :destroy
  	has_many :projects, through: :employee_projects
end
