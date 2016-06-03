class Api::V1::Merchant::RevenueController < Api::ApiController
  def index
    if merchant_params.keys == ["id", "date"]
      respond_with ::Merchant.revenue_for_merchant_by_date(merchant_params[:id].to_i, merchant_params[:date]), serializer: MerchantRevenueSerializer
    else
      respond_with ::Merchant.revenue_for_merchant(merchant_params[:id].to_i), serializer: MerchantRevenueSerializer
    end
  end

  private
    def merchant_params
      params.permit(:id, :date)
    end
end
