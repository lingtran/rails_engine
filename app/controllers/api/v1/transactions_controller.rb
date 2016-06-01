class Api::V1::TransactionsController < Api::ApiController
  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.search_by(transaction_params)
  end

  def find_all
    respond_with Transaction.find_all(transaction_params)
  end

  def random
    respond_with Transaction.rand
  end

  private

  def transaction_params
    params.permit(:invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
