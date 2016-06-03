class Api::V1::Merchant::RevenueController < Api::ApiController
  def index
    respond_with ::Merchant.revenue_for_merchant(merchant_params[:id].to_i), serializer: MerchantRevenueSerializer
  end

  private
    def merchant_params
      params.permit(:id)
    end
end
