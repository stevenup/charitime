class DonationsController < ApplicationController
  def index
    @donations = Donation.all
  end

  def new
    @donation = Donation.new
    @donation_record = DonationRecord.new
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
  def create_or_update(id = 0, data)
    if id == 0
      donation = Donation.new data
      donation_record = DonationRecord.new
      donation_state = DonationState.new
      donation_state.save
      donation_record.save
      donation.donation_record_id = donation_record.id
      donation.donation_state_id = donation_state.id
      redirect_to donations_path if donation.save
    else
      donation = Donation.find(id)
      redirect_to donations_path if donation.update_attributes data
    end
  end

  def donation_params
    params.require(:donation).permit(:donation_id, :donation_name, :donation_category_id, :donation_description, :logistics_company, :delivery_num )
  end
end