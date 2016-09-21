class HomeController < BaseController
  before_action :auth_user, only: [:index]

  def index
    @recommended_products = ShelfItem.where "recommended = '1'"
    @projects = Project.all.order(created_at: :desc)

  end

  def personal_center
    @user = current_user
  end

  def donations_center
  end

  def my_gyb
    @user = current_user
    type = params[:type]
    @gyb_incomes = GybIncome.where("user_id = ?", @user.id).order(created_at: :desc) if type == '0'
    @gyb_payments = GybPayment.where("user_id = ?", @user.id).order(created_at: :desc) if type == '1'
  end

  def project_detail
  end

  def product_detail
  end

  def donate_page
  end

  def my_address
  end

  def exchange
    exchange_code = params[:exchange_code]
    gyb = Gyb.find_by_exchange_code(exchange_code)
    if gyb.nil?
      render json: {status: 'exchange code not existed.'}
    else
      # determine whether the code is exchanged.
      if GybIncome.find_by_gyb_id(gyb.id).nil?
        # save the income gybs to the gyb_income table.
        gyb_income = GybIncome.new
        gyb_income.user_id = current_user.id
        gyb_income.gyb_id = gyb.id
        gyb_income.save
        gyb.stock -= 1
        gyb.save

        # update the total gybs of the user owned.
        current_user.gyb += gyb.price
        current_user.save
        redirect_to my_gyb_home_index_path
      else
        render json: { status: 'the code has been exchanged.'}
      end
    end
  end
end
