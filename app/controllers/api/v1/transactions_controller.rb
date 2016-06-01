class Api::V1::TransactionsController < Api::ApiController
  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end
end
