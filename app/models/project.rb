class Project < ApplicationRecord
	validates :name, presence: true

	has_many :employee_projects, dependent: :destroy
  has_many :employees, through: :employee_projects
end
