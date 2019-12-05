class EmployeesController < ApplicationController

	def index
		@employees = Employee.all
	end

	def new
		# return render body: params.inspect
		@employee = Employee.new		
	end

	def create
		# return render body: params.inspect
		@employee = Employee.new(employee_params)
		if @employee.save
			redirect_to employees_path
		else
			redirect_to new_employee_path
		end
	end

	def edit		
		@employee = Employee.find(params[:id])
	end

	def update
		@employee = Employee.find(params[:id])
		if @employee.update_attributes(employee_params)
			redirect_to employees_path
		else
			redirect_to edit_employee_path(@employee)
		end
	end

	def destroy
		@employee = Employee.find(params[:id])
		if @employee.destroy
			redirect_to employees_path
		else
			redirect_to employees_path
		end
	end

	def show
		@employee = Employee.find(params[:id])
		@projects = @employee.projects
	end
	private

	def employee_params
		params.require(:employee).permit(:name, :description, :company_name)
	end
end
