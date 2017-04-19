class ProjectsController < BaseController
  def index
    @projects = Project.where('is_published = ?', '1').order('updated_at DESC')
  end

  def detail
    id = params[:id]
    @project = Project.find_by_project_id(id)
    @shelf_items = ShelfItem.where('project_id = ? and is_on_shelf = ?', id, '1')

    @total, @num_dedication_support, @num_purchase_support, @percent = 0, 0, 0, 0

    @supports = Support.where('project_id = ? and status = ?', id, '1')

    if @supports != []
      @supports.each do |ele|
        if ele.money and ele.support_type == '0'
          @total                  += ele.money
          @num_dedication_support += 1
        elsif ele.order_detail_id and ele.support_type == '1'
          @total                  += ele.order_detail.gyb_discount.to_f / 100
          @num_purchase_support   += 1
        end
      end
      @percent = @total.to_f / @project.goal.to_f
    end

  end
end
