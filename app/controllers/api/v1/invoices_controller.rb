class Api::V1::InvoicesController < Api::ApiController
  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.search_by(invoice_params)
  end

  def find_all
    respond_with Invoice.find_all(invoice_params)
  end

  def random
    respond_with Invoice.rand
  end

  def transactions
    respond_with Invoice.has_transactions(params[:id])
  end

  def invoice_items
    respond_with Invoice.has_invoice_items(params[:id])
  end

  def items
    respond_with Invoice.has_items(params[:id])
  end

  def customer
    respond_with Invoice.has_customer(params[:id])
  end

  def merchant
    respond_with Invoice.has_merchant(params[:id])
  end

  private

    def invoice_params
      params.permit(:customer_id, :merchant_id, :status, :created_at, :updated_at)
    end
end
