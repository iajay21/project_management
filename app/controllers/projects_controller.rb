class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end

	def new
		# return render body: params.inspect
		@project = Project.new
		@employees = Employee.all
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			if params[:employee_ids].present?
				employee_ids = params[:employee_ids].map(&:to_i) 
				employee_ids.each do |eid|
					EmployeeProject.create(project_id: @project.id, employee_id: eid)					
				end
			end
			redirect_to projects_path
		else
			redirect_to new_project_path
		end
	end

	def edit
		@project = Project.find(params[:id])
		@employees = Employee.all		
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(project_params)
			@project_emp = EmployeeProject.where(project_id: @project.id)
			pemp_ids = @project_emp.map(&:employee_id) if @project_emp.present?
			if params[:employee_ids].present?
				employee_ids = params[:employee_ids].map(&:to_i) 
				employee_ids.each do |eid|
					if (pemp_ids.present? && pemp_ids.include?(eid))
						pemp_ids.delete(eid)
					else
						EmployeeProject.create(project_id: @project.id, employee_id: eid)					
					end
				end
				EmployeeProject.where(project_id: @project.id, employee_id: pemp_ids).destroy_all if pemp_ids.present?
			else
				EmployeeProject.where(project_id: @project.id).destroy_all
			end
			redirect_to projects_path
		else
			redirect_to edit_project_path(@project)
		end
	end

	def destroy
		@project = Project.find(params[:id])
		if @project.destroy
			redirect_to projects_path
		else
			redirect_to projects_path
		end
	end

	def show
		@project = Project.find(params[:id])
		@employees = @project.employees
	end

	private

	def project_params
		params.require(:project).permit(:name, :description)
	end

end
