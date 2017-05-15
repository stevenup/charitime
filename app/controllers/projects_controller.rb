class ProjectsController < BaseController
  def index
    @projects = Project.where('is_published = ?', '1').order('updated_at DESC')
  end

  def detail
    id = params[:id]
    @project = Project.find_by_project_id(id)
    @shelf_items = ShelfItem.where('project_id = ? and is_on_shelf = ?', id, '1')

    @total, @num_dedication_support, @num_purchase_support, @percent, @support_count, total_dedication_support = 0, 0, 0, 0, 0, 0
    @price_gap = '498'
    @supports  = Support.where('project_id = ? and status = ?', id, '1')

    if @supports != []
      @supports.each do |ele|
        if ele.money and ele.support_type == '0'
          @total                    += ele.money
          total_dedication_support  += ele.money
          @num_dedication_support   += ele.count
          @support_count            += (total_dedication_support / 49800).to_i
        elsif ele.support_type == '1'
          @total                    += ele.money
          @num_purchase_support     += ele.count
          @support_count            += @num_purchase_support
        end
      end
      # @percent = @total.to_f / @project.goal.to_f
      @price_gap = 498 - (total_dedication_support.to_f % 49800.0) / 100
      @percent   = (total_dedication_support % 49800.0).to_f / 49800.0
    end
  end
end
