class ProjectsController < BaseController
  def index
    @projects = Project.where("is_published = ?", '1').order("updated_at DESC")
  end

  def detail
    id = params[:id]
    @project = Project.find_by_project_id(id)
    @shelf_items = ShelfItem.where("project_id = ? and is_on_shelf = ?", id, 1)
  end
end
