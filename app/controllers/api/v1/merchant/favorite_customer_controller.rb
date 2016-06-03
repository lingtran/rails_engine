class Api::V1::Merchant::FavoriteCustomerController < Api::ApiController
  def index
    respond_with Merchant.favorite_customer_for_merchant(merchant_params[:id])
  end

  private
  def merchant_params
    params.permit(:id)
  end
end
