class Api::V1::Item::BestDayController < Api::ApiController
  def index
    respond_with ::Item.best_day(item_params[:id].to_i), serializer: DateSerializer
  end

  private
    def item_params
      params.permit(:id)
    end
end
