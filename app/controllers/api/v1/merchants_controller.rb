class Api::V1::MerchantsController < Api::ApiController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  private
  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
