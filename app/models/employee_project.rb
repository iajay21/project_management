class EmployeeProject < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  validates :project_id, :employee_id, presence: true
end
