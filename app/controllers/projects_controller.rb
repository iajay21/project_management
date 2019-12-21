class ProjectsController < ApplicationController
	def index
		@projects = Project.all
		@q = Project.ransack(params[:q])
  	@searched_projects = @q.result(distinct: true)
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to projects_path
		else
			redirect_to new_project_path
		end
	end

	def edit
		@project = Project.find(params[:id])	
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(project_params)
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
		params.require(:project).permit(:name, :description, employee_ids: [])
	end

end
