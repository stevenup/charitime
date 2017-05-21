class GybsController < BaseController
  def index
    @gyb_incomes = GybIncome.where("user_id = ?", current_user.id.to_s).order(created_at: :desc)
    @user        = current_user
  end

  def append
    respond_to do |format|
      format.html
      format.js { fetch(params[:type]) }
    end
  end

  def exchange
    exchange_code = params[:exchange_code]
    gyb           = Gyb.find_by_exchange_code(exchange_code)
    if gyb.nil?
      flash[:type]    = 'alert'
      flash[:message] = '该兑换码无效！'
      redirect_to gybs_path
      # render json: { status: 'exchange code not existed.' }
    else
      # determine whether the current user has exchanged the code.
      if GybIncome.where("user_id = ? and gyb_id = ?", current_user.id.to_s, gyb.id) == []
        # Save the income gybs to the gyb_income table.
        gyb_income         = GybIncome.new
        gyb_income.user_id = current_user.id.to_s
        gyb_income.gyb_id  = gyb.id
        gyb_income.save
        gyb.stock -= 1
        gyb.save

        # update the total gybs of the user owned.
        current_user.gyb += gyb.price
        current_user.save
        flash[:type]    = 'alert'
        flash[:message] = '兑换成功！'
        redirect_to gybs_path
      else
        # render json: { status: 'You have exchanged the code.' }
        flash[:type]    = 'alert'
        flash[:message] = '该兑换码已被兑换完毕！'
        redirect_to gybs_path
      end
    end
  end

  private
  def fetch(type)
    @gyb_incomes  = GybIncome.where("user_id = ?", current_user.id.to_s).order(created_at: :desc) if type == '0'
    @gyb_payments = GybPayment.where("user_id = ?", current_user.id.to_s).order(created_at: :desc) if type == '1'
  end
end