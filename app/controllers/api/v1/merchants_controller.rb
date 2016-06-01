class Api::V1::MerchantsController < Api::ApiController
  def index
    respond_with Merchant.basic.all
  end

  def show
    respond_with Merchant.basic.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.search_by(merchant_params)
  end

  def find_all
    respond_with Merchant.find_all(merchant_params)
  end

  def random
    respond_with Merchant.rand
  end

  private
    def merchant_params
      params.permit(:name, :created_at, :updated_at)
    end
end
