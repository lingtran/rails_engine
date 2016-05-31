class Api::V1::MerchantsController < Api::ApiController
  respond_to :json

  def index
    respond_with Merchant.all
  end
end
