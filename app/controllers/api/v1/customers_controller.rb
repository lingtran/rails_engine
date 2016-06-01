class Api::V1::CustomersController < Api::ApiController
  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end
end
