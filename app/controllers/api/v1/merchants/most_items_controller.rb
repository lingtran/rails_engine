class Api::V1::Merchants::MostItemsController < Api::ApiController
  def index
    respond_with Merchant.ranked_by_most_items(most_items_params[:quantity].to_i)
  end

  private
    def most_items_params
      params.permit(:quantity)
    end
end
