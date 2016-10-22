class ProjectsController < ApplicationController
  before_action :load_projects_kind, except: :index

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_url
    else
      render action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
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
    params.require(:project).permit(:name, :desc, :repo_url, :kind_id)
  end

  def load_projects_kind
    @projects_kind = ProjectKind.all
  end
end
