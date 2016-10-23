class DeploymentsController < ApplicationController
  def create
    project = current_user.projects.find(params[:project_id])
    @deployment = project.deployments.build

    if @deployment.save
      render action: :show
    else
      flash[:error] = 'Ooops! Something went wrong!'
      redirect_to projects_path
    end
  end

  def show
    @deployment = Deployment.find(params[:id])
  end
end
