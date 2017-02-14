class Api::V1::ProjectsController < ApplicationController
  def index
    param = params[:param]
    if param == 'recommended'
      projects = Project.where('is_published = ? and is_recommended = ?', '1', '1')
      render json: projects, status: :ok
    else
      projects = Project.where('is_published = ?', '1')
      render json: projects, status: :ok
    end
  end

  def get_project
    pid = params[:pid]
    if pid
      project = Project.find_by(:project_id => pid)
      render json: project, status: :ok if project
    end
  end
end