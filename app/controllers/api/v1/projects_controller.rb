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

  def get_linked_shelf_items
    pid = params[:pid]
    if pid
      shelf_items = ShelfItem.where('is_on_shelf = ? and project_id = ?', '1', pid)
      render json: shelf_items, status: :ok
    else
      render json: { data: 'no request params.' }
    end

  end
end