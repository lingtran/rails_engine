class Api::V1::Merchants::RevenueController < Api::ApiController
  def index
    respond_with ::Merchant.total_revenue_by_date(revenue_params[:date]), serializer: RevenueSerializer
  end

  private
  def revenue_params
    params.permit(:date)
  end
end
