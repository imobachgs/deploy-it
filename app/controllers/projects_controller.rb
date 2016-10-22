class ProjectsController < ApplicationController
  before_action :load_projects_kind, except: :index

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_url
    else
      render action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @roles = Role.all
    @machines = Machine.all
    @roles.each { @project.assignments.build if @project.assignments.count < Role.all.count}
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to projects_url
    else
      render action: :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :name,
      :desc,
      :repo_url,
      :kind_id,
      :user_id,
      assignments_attributes: [
        :id,
        :project_id,
        :role_id,
        :machine_id
      ]
    )
  end

  def load_projects_kind
    @projects_kind = ProjectKind.all
  end
end
