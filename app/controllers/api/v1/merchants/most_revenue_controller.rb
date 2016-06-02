class Api::V1::Merchants::MostRevenueController < Api::ApiController
  def index
    respond_with Merchant.ranked_by_most_revenue(most_rev_params[:quantity].to_i)
  end

  private
    def most_rev_params
      params.permit(:quantity)
    end
end
