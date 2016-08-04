class ProjectsController < BaseController
  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def detail
    id = params[:id]
    @project = Project.find_by_id(id)
  end

  def xx

    if condition
      i = 1
      ii = 11
      iii = 111
    end
  end
end
