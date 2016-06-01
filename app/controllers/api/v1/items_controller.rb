class Api::V1::ItemsController < Api::ApiController
  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end
end
