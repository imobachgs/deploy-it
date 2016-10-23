class ProjectsController < ApplicationController
  before_action :load_projects_kind, except: :index
  before_action :check_machines, except: :index

  def index
    unless current_user.has_machines?
      flash.now[:alert] = 'Remember! You must have a machine for management projects.'
    end

    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    klass = "#{ProjectKind.find(params[:project][:kind_id]).try(:name)}Project".constantize
    @project = klass.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      redirect_to edit_project_path(@project)
    else
      render action: :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    load_project_roles
    load_machines
    @roles.each do |key, value|
      @project.assignments.build(role_id: key) if @project.assignments.count < @roles.count
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_type_params)
      redirect_to projects_url
    else
      load_project_roles
      load_machines
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
      :user_id
    )
  end

  def project_type_params
    params.require(@project.type.underscore.to_sym).permit(
      :name,
      :desc,
      :repo_url,
      :kind_id,
      :user_id,
      :database_adapter,
      :database_name,
      :database_username,
      :database_passwrod,
      :ruby_version,
      :port,
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

  def load_project_roles
    @roles = {}
    @project.available_roles.each { |x| @roles[x.id] = x.name }
  end

  def load_machines
    @machines = current_user.machines
  end

  def check_machines
    unless current_user.has_machines?
      flash[:error] = 'You need machines before create projects'
      redirect_to root_path
    end
  end
end
