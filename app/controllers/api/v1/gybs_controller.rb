class Api::V1::GybsController < ApplicationController
  def get_gyb_income_records
    user_id = params[:user_id]
    gyb_incomes = GybIncome.where('user_id = ?', user_id)
    gyb_income_records = []
    gyb_incomes.each do |ele|
      gyb_income_records.push(format_gyb_records('income', ele))
    end
    render json: gyb_income_records, status: :ok if gyb_income_records
  end

  def get_gyb_payment_records
    user_id = params[:user_id]
    gyb_payments = GybPayment.where('user_id = ?', user_id)
    gyb_payment_records = []
    gyb_payments.each do |ele|
      gyb_payment_records.push(format_gyb_records('payment', ele))
    end
    render json: gyb_payment_records, status: :ok if gyb_payment_records
  end

  private

    def format_gyb_records(income_or_payment, record)
      flag = income_or_payment
      gyb_records = {}
      gyb_records[:id] = record.id
      gyb_records[:created_at] = record.created_at.strftime('%Y-%m-%d %T')
      if flag == 'income'
        gyb_records[:title] = record.gyb.title
        if record.gyb.gyb_type == 0
          gyb_records[:remark] = record.remark
          gyb_records[:gyb_discount] = OrderDetail.find_by_order_id(record.remark).try(:gyb_discount)
        else
          gyb_records[:gyb_price] = record.price
        end
      else  # if == 'payment'
        gyb_records[:product_name] = OrderDetail.find_by_order_id(record.order_id).try(:product_name)
        gyb_records[:gyb_discount] = OrderDetail.find_by_order_id(record.order_id).try(:gyb_discount)
      end
      gyb_records
    end
end