class Api::V1::Items::MostItemsController < Api::ApiController
  def index
    respond_with ::Item.ranked_by_most_items(item_params[:quantity].to_i)
  end

  private
    def item_params
      params.permit(:quantity)
    end
end
