class Admin::DonationsController < Admin::AuthenticatedController
  def index
    respond_to do |format|
      format.html
      format.json { get_rows }
    end
  end

  def edit
    @donation = Donation.find params[:id]
  end

  def create
    create_or_update donation_params
  end

  def update
    create_or_update params[:id], donation_params
  end

  private
  def get_rows
    dt = decode_datatables_params

    where_array = []

    search_obj = {
        :include => [],
        :joins => [],
        :order => dt[:sort_statement],
        :conditions => [where_array.join(' AND ')]
    }

    @total_rows = Donation.count(search_obj)
    @rows = Donation.page(dt[:page]).per(dt[:per_page])
                .includes(search_obj[:include])
                .joins(search_obj[:joins])
                .order(search_obj[:order])
                .where(search_obj[:conditions])
  end

  def create_or_update(id = 0, data)
    if id == 0
      donation = Donation.new data
      redirect_to admin_donations_path if donation.save
    else
      donation = Donation.find(id)
      redirect_to admin_donations_path if donation.update_attributes data
    end
  end

  def donation_params
    params.require(:donation).permit(:donation_id, :donation_name, :donation_category_id, :donation_description, :logistics_company, :delivery_num )
  end
end